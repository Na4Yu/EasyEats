const admin = require("firebase-admin");
const filterorderC = require("./filterorderC");
const filterserveC = require("./filterserveC");
const filterorderG = require("./filterorderG");
const filterserveG = require("./filterserveG");
const filterorderS = require("./filterorderS");
const filterserveS = require("./filterserveS");
const filterorderT = require("./filterorderT");
const filterserveT = require("./filterserveT");
const filterorderY = require("./filterorderY");
const filterserveY = require("./filterserveY");
const queueProcess = require("./queueprocess");
admin.initializeApp();

exports.filterorderC = filterorderC;
exports.filterserveC = filterserveC;
exports.filterorderG = filterorderG;
exports.filterserveG = filterserveG;
exports.filterorderS = filterorderS;
exports.filterserveS = filterserveS;
exports.filterorderT = filterorderT;
exports.filterserveT = filterserveT;
exports.filterorderY = filterorderY;
exports.filterserveY = filterserveY;
exports.queueProcess = queueProcess;

