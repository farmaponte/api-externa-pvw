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
    return this.hasMany('/App/Models/ClienteConvenioFuncionario', 'ai', 'ai')
  }

  // convenios() {
  //   return this.hasMany('/App/Models/ClienteConvenioEspecial')
  // }

  static get computed() {
    return ['tipo_fidelidade']
  }

  getTipoFidelidade({ id_convenio }) {
    return id_convenio ? 'FIDELIDADE + CONVÊNIO' : 'FIDELIDADE'
  }
}

module.exports = Cliente
