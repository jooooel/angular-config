import { Component, Inject } from '@angular/core';
import { Configuration, configurationToken } from 'src/configuration/configuration';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'angular-config';
  myCustomSetting;

  constructor(@Inject(configurationToken) private configuration: Configuration) {
    this.myCustomSetting = configuration.myCustomSetting
  }
}