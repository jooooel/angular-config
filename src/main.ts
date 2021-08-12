import { enableProdMode } from '@angular/core';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { configurationToken } from './configuration/configuration';

// Platform creation and bootstrapping of the application is delayed until we have loaded the configuration file.
// The configuration file will be replaces (in Dockerfile) based on environment
let configurationPath = `/configuration/configuration.json`;
fetch(configurationPath)
    .then(response => response.json())
    .then(configuration => {
        if (configuration.production) {
            enableProdMode();
        }

        return platformBrowserDynamic([
            { provide: configurationToken, useValue: configuration },
        ]).bootstrapModule(AppModule);
    })
    .catch(error => console.error(error));