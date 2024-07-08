const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {

    const db = await cds.connect.to ('db');
    const { User } = db.entities ('sap.sample.cpapp');

    const incSrv = await cds.connect.to ('incidentService');
    incSrv.on('addUser', async(msg) => {
        return incSrv.run(INSERT.into(User).entries({userID: msg.data.uid, name: msg.data.fname, gender: msg.data.gender, prodID_ProductID: msg.data.prodID}));
    });

});