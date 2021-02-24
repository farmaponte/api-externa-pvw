'use strict'

const Cliente = use('App/Models/Cliente')
const ClienteConvenioFuncionario = use('App/Models/ClienteConvenioFuncionario')

/** @typedef {import('@adonisjs/framework/src/Request')} Request */
/** @typedef {import('@adonisjs/framework/src/Response')} Response */
/** @typedef {import('@adonisjs/framework/src/View')} View */

/**
 * Resourceful controller for interacting with clientes
 */
class ClientePesquisaController {
  /**
   * Show a list of all clientes.
   * GET clientes
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async index({ request, response }) {
    const { termo } = request.all()

    if (!isNaN(termo)) {
      const clientesCPF = await Cliente
        .query()
        .with('convenios_funcionario')
        .where('cpf', termo)
        .fetch()

      if (clientesCPF.toJSON().length > 0) {
        return { tipoPesquisa: 'CPF', clientes: clientesCPF }
      }

      const funcodempPosicao = [2, 5]
      const funcodintPosicao = 7
      const funcodemp = parseInt(termo.substring(
        funcodempPosicao[0] - 1,
        funcodempPosicao[0] - 1 + funcodempPosicao[1]
      ), 10)
      const funcodint = parseInt(termo.substring(
        funcodintPosicao - 1,
        termo.length
      ), 10)

      if (!isNaN(funcodint) && !isNaN(funcodemp)) {
        const clienteConvenioFuncionario = await ClienteConvenioFuncionario
          .query()
          .where('funcodemp', '=', funcodemp)
          .andWhere('funcodint', '=', funcodint)
          .fetch()

        if (clienteConvenioFuncionario.toJSON().length > 0) {
          return { tipoPesquisa: 'Convênio', clientes: clienteConvenioFuncionario }
        }
      }
    }

    const clientesNome = await Cliente
      .query()
      //.with('convenios_funcionario')
      .where('nome', 'ilike', `%${termo}%`)
      .fetch()

    return { tipoPesquisa: 'Nome', clientes: clientesNome }
  }

  /**
   * Create/save a new cliente.
   * POST clientes
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async store({ request, response }) {
  }

  /**
   * Display a single cliente.
   * GET clientes/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async show({ params, request, response }) {
  }

  /**
   * Update cliente details.
   * PUT or PATCH clientes/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async update({ params, request, response }) {
  }

  /**
   * Delete a cliente with id.
   * DELETE clientes/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async destroy({ params, request, response }) {
  }
}

module.exports = ClientePesquisaController
