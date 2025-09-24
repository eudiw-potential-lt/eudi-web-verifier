const fs = require('fs');
// Configure Angular `environment.ts` file path
const targetPath = './src/environments/environment.ts';
// Load node modules
require('dotenv').config();
// `environment.ts` file structure
const envConfigFile = `export const environment = {
    apiUrl: '${process.env.API_URL}',
    appName: '${process.env.APP_NAME}',
    basePath: '${process.env.BASE_HREF}'
};`;

console.log(envConfigFile);
fs.writeFile(targetPath, envConfigFile, (err) => {
	if (err) {
		throw console.error(err);
	} else {
		console.log((`Angular environment.ts file generated correctly at ${targetPath} \n`));
	}
});
