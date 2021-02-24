'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class EmpresaConvenio extends Model {
  static get table() {
    return 'fdw_pg15.stfil001'
  }

  static get createdAtColumn() {
    return null
  }

  static get updatedAtColumn() {
    return null
  }
}

module.exports = EmpresaConvenio
