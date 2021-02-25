'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class ClienteConvenio extends Model {
  static boot() {
    super.boot()
    this.addHook('afterFind', 'ClienteConvenioHook.corrigeIdCliente')
    this.addHook('afterFetch', 'ClienteConvenioHook.corrigeIdClientes')
  }

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
    return this.hasOne('App/Models/Convenio', 'tb_convenios_id', 'id')
  }

  cliente() {
    return this.hasOne('App/Models/Cliente', 'tb_clientes_id', 'id')
  }
}

module.exports = ClienteConvenio
