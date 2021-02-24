'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class Cliente extends Model {
  static get table() {
    return 'fidelidade.tb_clientes'
  }

  static get createdAtColumn() {
    return null
  }

  static get updatedAtColumn() {
    return null
  }

  convenios_funcionario() {
    return this.hasMany('App/Models/ClienteConvenioFuncionario', 'id_convenio', 'ai')
  }

  convenios() {
    return this.hasMany('App/Models/ClienteConvenio')
  }
}

module.exports = Cliente
