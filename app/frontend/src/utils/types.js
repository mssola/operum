// Returns true if the given argument is exactly null or 'undefined'.
const isnull = (arg) => arg === null || typeof (arg) === 'undefined';

// Returns true of the given string has an empty value.
const isblank = (str) => str === '' || isnull(str);

export default {
  isnull,
  isblank,
};
