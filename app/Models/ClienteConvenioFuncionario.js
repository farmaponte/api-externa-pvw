'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class ClienteConvenioFuncionario extends Model {
  static get table() {
    return 'fdw_pg15.stfil002'
  }

  static get createdAtColumn() {
    return null
  }

  static get updatedAtColumn() {
    return null
  }

  empresa() {
    return this.hasOne('App/Models/EmpresaConvenio', 'funcodemp', 'empcodemp')
  }

  cliente() {
    return this.hasOne('App/Models/Cliente', 'ai', 'id_convenio')
  }
}

module.exports = ClienteConvenioFuncionario
