// Supported languages. Note that I'm only writing 'en' instead of the myriad of
// combinations. This is because 'en' is the default language, so if it's not
// found in `setCurrentLanguage` then it will be applied anyways.
const SUPPORTED = ["ca", "en"];

// Language for the application.
let currentLanguage = "en";

// Fetches the language as requested by the browser and sets the internal
// `currentLanguage` variable to our best guess. If this could not be found,
// then we take English as the default.
const setCurrentLanguage = () => {
  let langs = navigator.languages;
  if (!langs) {
    langs = ["en"];
  }

  currentLanguage = langs.find((l) => SUPPORTED.includes(l)) || "en";
};

// Returns the code for the current language.
const getLanguage = () => {
  return currentLanguage;
};

// Returns the translated value for the given key. This is done by trying to
// fetch an element by an ID with an agreed format. Make sure that it exists. If
// it's not found, then they key is simply returned, which is ugly, but at least
// it's something to show...
const t = (key) => {
  let val = document.getElementById(`msg.${currentLanguage}.${key}`);
  return val ? val.textContent : key;
};

export default {
  t,
  setCurrentLanguage,
  getLanguage,
};
