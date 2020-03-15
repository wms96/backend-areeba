const { body } = require('express-validator/check');
const { validationResult } = require('express-validator/check');
const connection = require('../config/database.js');

module.exports.insert = (req, res) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() })
    }
    credit = req.body;

    const CURRENT_TIMESTAMP = { toSqlString: function () { return 'CURRENT_TIMESTAMP()'; } };
    credit.created_at = CURRENT_TIMESTAMP;
    connection.query('INSERT INTO credit SET ?', credit, function (error, results, fields) {
        if (error) res.json({ status: 0, message: error });
            // console.log('results ', results)
            res.json({ status: 1, message: "Transaction Added (Credit)" })
    });
}

exports.validate = (method) => {
    switch (method) {
        case 'insert': {
            return [
                body('client_id', "client id doesn't exists").exists().isLength({ min: 1 }),
                body('amount', "amount doesn't exists").exists().isLength({ min: 1 }),
                body('details', "details doesn't exists").exists(),
            ]
        }
    }
}