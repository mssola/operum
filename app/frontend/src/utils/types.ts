// Returns true if the given argument is exactly null or 'undefined'.
const isnull = (arg): boolean => arg === null || typeof arg === "undefined";

// Returns true of the given string has an empty value.
const isblank = (str): boolean => str === "" || isnull(str);

export default {
  isnull,
  isblank,
};
