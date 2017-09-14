var fs = require('fs');

function requireFromString(src, filename) {
   var Module = module.constructor;
   var m = new Module();
   m._compile(src, filename);
   return m.exports;
 }

var props = 'app = {}; \n' + fs.readFileSync( process.argv[2], 'utf8' );

props += "\n module.exports = { prop: app.prop, langConfig: app.langConfig };";

config = requireFromString(props, '');

config.prop.restBaseUrl = process.argv[3];
config.prop.googleApiKey = process.argv[4];
config.prop.paljet = (process.argv[5].toUpperCase() == "TRUE");

var newConfig = 'app.prop = ' + JSON.stringify(config.prop, null, 3) + ';\n\r app.langConfig = ' + JSON.stringify(config.langConfig, null, 3) + ';';
fs.writeFileSync('./properties.js', newConfig);
