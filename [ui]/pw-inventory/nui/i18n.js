const baseScriptSrc = 'pw-inventory:scripts:';

const ignoreStartsWith = [
  'ply-',
];

let translationsObject = null;
let langCode = null;

let stringsToAdd = [];
const stringsProcessed = [];


const reversalMap = {};

const _i18n = (str, src) => {
  if (!translationsObject || !langCode || !str) {
    return str;
  }
  if (langCode === 'en' && reversalMap[str]) {
    return reversalMap[str];
  }
  for (const i of ignoreStartsWith) {
    if (str.indexOf(i) === 0) {
      return str;
    }
  }
  const source = `${baseScriptSrc}${src || 'misc'}`;
  if (!stringsProcessed.includes(str) && langCode === 'en') {
    stringsToAdd.push({ string: str, source });
  }
  if (langCode === 'en') {
    return str;
  }
  if (
    translationsObject &&
    translationsObject[str] &&
    translationsObject[str][langCode]
  ) {
    reversalMap[translationsObject[str][langCode]] = str;
    return translationsObject[str][langCode];
  }
  return str;
}
