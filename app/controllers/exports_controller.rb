# frozen_string_literal: true

class ExportsController < ApplicationController
  before_action :set_search
  before_action :set_results, only: %i[show]

  def show
    respond_to do |format|
      format.csv { set_file_name!(ext: 'csv') }
      format.uoc { set_file_name!(ext: 'tex') }
      format.text do
        send_data PlainExporter.new(things: @results).export,
                  type:        'text/plain',
                  disposition: 'attachment',
                  filename:    "#{@search.name}.txt"
      end
    end
  end

  def new; end

  protected

  # Sets the file name for the attachment according to the @search's name, and
  # it adds the given string `ext` as the extension.
  def set_file_name!(ext:)
    response.headers['Content-Disposition'] = "attachment; filename=\"#{@search.name}.#{ext}\""
  end

  # Set @search. If there was no `:search_id` parameter, then we assume that the
  # ID = 0, which is the fake search we use for the base 'Home' (i.e. get
  # everything).
  def set_search
    @search = if params[:search_id].to_i.zero?
                Search.new(id: 0, name: 'Home')
              else
                Search.find(params[:search_id])
              end
  end

  def set_results
    @results = @search.results.fetch(:things, [])
  end
end
