"use strict";
const vscode = require("vscode");
var workspace = vscode.workspace;
class BaseSettings {
    readSetting(name, defaultValue) {
        let configuration = workspace.getConfiguration();
        let value = configuration.get(name, undefined);
        // If user specified a value, use it
        if (value !== undefined && value !== null) {
            return value;
        }
        return defaultValue;
    }
}
class Settings extends BaseSettings {
    constructor() {
        super();
        this._enabled = this.readSetting("randomeverything.enabled", true);
    }
    get Enabled() {
        return this._enabled;
    }
}
exports.Settings = Settings;
//# sourceMappingURL=settings.js.map