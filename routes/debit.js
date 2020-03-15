const router = require('express').Router();
const debit = require('../controllers/debit.js');


router.post('/insert', 
  debit.validate('insert'), 
  function (req, res) {
    debit.insert(req, res) 
})

router.post('/sendTransaction', 
  function (req, res) {
    debit.sendTransaction(req, res) 
})

module.exports = router
