import { InjectionToken } from "@angular/core";

export interface Configuration {
    production: boolean
    myCustomSetting: string
}

// We use a dependency injection token to access the configuration in our application.
export const configurationToken = new InjectionToken('Configuration');