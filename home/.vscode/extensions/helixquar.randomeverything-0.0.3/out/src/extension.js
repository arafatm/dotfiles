'use strict';
const vscode = require("vscode");
const settings_1 = require("./settings");
const fs = require("fs");
var Window = vscode.window;
var Range = vscode.Range;
function activate(context) {
    var settings = new settings_1.Settings();
    if (!settings.Enabled) {
        console.log("The extension \"randomeverything\" is disabled.");
        return;
    }
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.int', insertRandomInt));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.float', insertRandomFloat));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.letters', insertRandomLetters));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.lettersAndNumbers', insertRandomLettersAndNumbers));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.country', insertRandomCountry));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.word', insertRandomWord));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.text', insertRandomText));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.date', insertRandomDate));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.firstName', insertRandomFirstName));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.lastName', insertRandomLastName));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.fullName', insertRandomFullName));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.email', insertRandomEmail));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.url', insertRandomUrl));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.hexColor', insertRandomHexColor));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.iPv4Address', insertRandomIPv4Address));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.iPV6Address', insertRandomIPV6Address));
    context.subscriptions.push(vscode.commands.registerCommand('randomeverything.guid', insertRandomGUID));
}
exports.activate = activate;
function insertRandomInt() {
    var max;
    var min;
    Window.showInputBox({ prompt: "Please enter [MIN-MAX]", value: "1-100" }).then(function (txt) {
        if (txt) {
            var args = txt.split("-");
            min = Number.parseInt(args[0]);
            max = Number.parseInt(args[1]);
            if (args.length != 2 || isNaN(min) || isNaN(max)) {
                //@TODO: Error handling practices for vscode extensions
                Window.showErrorMessage("Invalid format.");
                return;
            }
            processSelection(randomIntString, [min, max]);
        }
    });
}
function insertRandomFloat() {
    var max;
    var min;
    Window.showInputBox({ prompt: "Please enter [MIN-MAX]", value: "1-100" }).then(function (txt) {
        if (txt) {
            var args = txt.split("-");
            min = Number.parseInt(args[0]);
            max = Number.parseInt(args[1]);
            if (args.length != 2 || isNaN(min) || isNaN(max)) {
                //@TODO: Error handling practices for vscode extensions
                Window.showErrorMessage("Invalid format.");
                return;
            }
            processSelection(randomFloatString, [min, max]);
        }
    });
}
function insertRandomLetters() {
    processSelection(randomLetters, []);
}
function insertRandomLettersAndNumbers() {
    processSelection(randomLettersAndNumbers, []);
}
function insertRandomCountry() {
    processSelection(randomCountry, [true]);
}
function insertRandomWord() {
    processSelection(randomWord, []);
}
function insertRandomText() {
    processSelection(randomText, []);
}
function insertRandomDate() {
    processSelection(randomDate, []);
}
function insertRandomFirstName() {
    processSelection(randomName, ['first']);
}
function insertRandomLastName() {
    processSelection(randomName, ['last']);
}
function insertRandomFullName() {
    processSelection(randomName, ['full']);
}
function insertRandomEmail() {
    processSelection(randomEmail, []);
}
function insertRandomUrl() {
    processSelection(randomUrl, []);
}
function insertRandomHexColor() {
    processSelection(randomColor, []);
}
function insertRandomIPv4Address() {
    processSelection(randomIP, ['ipv4']);
}
function insertRandomIPV6Address() {
    processSelection(randomIP, ['ipv6']);
}
function insertRandomGUID() {
    processSelection(randomGUID, []);
}
/**
 * Chance.js Wrappers
 */
function randomIntString(min, max) {
    var chance = require('chance').Chance();
    var randomVar = chance.integer({ min: min, max: max });
    return randomVar.toString();
}
function randomFloatString(min, max) {
    var chance = require('chance').Chance();
    var randomVar = chance.floating({ min: min, max: max });
    return randomVar.toString();
}
function randomLetters(min, max) {
    var chance = require('chance').Chance();
    var randomVar = chance.string({ pool: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" });
    return randomVar;
}
function randomLettersAndNumbers(min, max) {
    var chance = require('chance').Chance();
    var randomVar = chance.string({ pool: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" });
    return randomVar;
}
function randomCountry(isFull) {
    var chance = require('chance').Chance();
    var randomVar = chance.country({ full: isFull });
    return randomVar;
}
function randomWord() {
    var chance = require('chance').Chance();
    let extensionPath = vscode.extensions.getExtension("helixquar.randomeverything").extensionPath;
    var strings = fs.readFileSync(extensionPath + "/assets/words.short.txt")
        .toString()
        .split("\r\n");
    var randomVar = chance.pickone(strings);
    return randomVar;
}
function randomText() {
    var chance = require('chance').Chance();
    let extensionPath = vscode.extensions.getExtension("helixquar.randomeverything").extensionPath;
    var strings = fs.readFileSync(extensionPath + "/assets/words.short.txt")
        .toString()
        .split("\r\n");
    var randomVar = chance.pickset(strings, 24);
    return randomVar.join(' ');
}
function randomDate() {
    var chance = require('chance').Chance();
    var randomVar = chance.date({ string: true });
    return randomVar;
}
function randomName(format) {
    var chance = require('chance').Chance();
    var randomVar;
    switch (format) {
        case 'first':
            randomVar = chance.first();
            break;
        case 'last':
            randomVar = chance.last();
            break;
        case 'full':
        default:
            randomVar = chance.name();
            break;
    }
    return randomVar;
}
function randomEmail() {
    var chance = require('chance').Chance();
    var randomVar = chance.email();
    return randomVar;
}
function randomUrl() {
    var chance = require('chance').Chance();
    var randomVar = chance.url();
    return randomVar;
}
function randomColor() {
    var chance = require('chance').Chance();
    var randomVar = chance.color({ format: 'hex' });
    return randomVar;
}
function randomIP(option) {
    var chance = require('chance').Chance();
    var randomVar;
    switch (option) {
        default:
        case 'ipv4':
            randomVar = chance.ip();
            break;
        case 'ipv6':
            randomVar = chance.ipv6();
            break;
    }
    return randomVar;
}
function randomGUID() {
    var chance = require('chance').Chance();
    var randomVar = chance.guid();
    return randomVar;
}
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
// This function takes a callback function for the text formatting 'formatCB'
function processSelection(formatCB, argsCB) {
    let e = Window.activeTextEditor;
    let d = e.document;
    let sel = e.selections;
    e.edit(function (edit) {
        // iterate through the selections
        for (var x = 0; x < sel.length; x++) {
            let txt = d.getText(new Range(sel[x].start, sel[x].end));
            if (argsCB.length > 0) {
                txt = formatCB.apply(this, argsCB);
            }
            else {
                txt = formatCB();
            }
            //insert the txt in the start of the current selection
            edit.insert(sel[x].start, txt);
        }
    });
}
//# sourceMappingURL=extension.js.map