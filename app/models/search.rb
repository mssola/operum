# frozen_string_literal: true

class Search < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true

  belongs_to :user

  # Returns all the results that can be fetched with the current `body`. It's
  # returned into a hash which groups the taggable types.
  def results
    # This can happen as part of an empty Search.new instance. That is, it's
    # still invalid, but it's the object being initialized for the default
    # search (i.e. just show me everything).
    return { things: Thing.order('rate DESC, created_at'), comments: [] } if body.blank?

    # Parse the body of the search, and return early if nothing was able to be
    # parsed (e.g. user wrote unknown identifiers).
    parsed = parse_body
    return { things: [], comments: [] } if parsed.all? { |_, v| v.blank? }

    # And add everything into the `res` hash with the results.
    res = find_by_text(plain: parsed[:plain])
    find_by_tags(res:, tags: parsed[:tag])
  end

  protected

  # Returns a hash which contains the tags that has been specified (`tag`) and
  # the plain text (`plain`) to check on the different fields.
  def parse_body
    res = { tag: [], plain: [] }

    body.split.each do |part|
      if part.include?(':')
        parts = part.split(':', 2)
        parts[1] = clean_clause(part: parts[1])

        next if parts[0] != 'tag'

        res[parts[0].to_sym] << parts[1]
      else
        res[:plain] << part
      end
    end

    res
  end

  # Returns the argument without any leading/trailing quotes.
  def clean_clause(part:)
    part.gsub(/^("|')+/, '').gsub(/("|')+$/, '')
  end

  # Returns a hash which groups into taggable types the results by looking the
  # `plain` text into different fields.
  def find_by_text(plain:)
    res = { things: [], comments: [] }

    plain.each do |text|
      res[:things] = if res[:things].any?
                       res[:things].and(Thing.like(text:)).order('rate DESC, created_at')
                     else
                       Thing.like(text:).order('rate DESC, created_at')
                     end
      res[:comments] = if res[:comments].any?
                         res[:comments].and(Comment.like(text:)).order(:created_at)
                       else
                         Comment.like(text:).order(:created_at)
                       end
    end

    res
  end

  # Returns a hash which groups into taggable types the results by matching the
  # given `tags` which their references. It expects `res` to be already
  # initialized by `find_by_text` (yeah, great design, I know), which is also
  # the structure that will be returned.
  def find_by_tags(res:, tags:)
    return res if tags.blank?

    tags = tags.map { |name| Tag.find_by(name:) }

    query = TagReference.where(tag: tags, taggable_type: 'Thing')
    query = query.where(taggable_id: res[:things].pluck(:id)) if res[:things].present?
    res[:things] = query.group(:taggable_id)
                        .having('count(taggable_id) = ?', tags.size)
                        .map(&:taggable)

    query = TagReference.where(tag: tags, taggable_type: 'Comment')
    query = query.where(taggable_id: res[:comments].pluck(:id)) if res[:comments].present?
    res[:comments] = query.group(:taggable_id)
                          .having('count(taggable_id) = ?', tags.size)
                          .map(&:taggable)

    res
  end
end
