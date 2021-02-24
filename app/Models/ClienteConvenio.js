'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class ClienteConvenio extends Model {
  static get table() {
    return 'fidelidade.tb_convenios_clientes'
  }

  static get createdAtColumn() {
    return null
  }

  static get updatedAtColumn() {
    return null
  }

  convenio() {
    return this.hasOne('/App/Models/Convenio')
  }
}

module.exports = ClienteConvenio
