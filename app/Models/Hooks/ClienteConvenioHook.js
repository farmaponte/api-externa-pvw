'use strict'

const Convenio = use('App/Models/Convenio')

const ClienteConvenioHook = exports = module.exports = {}

ClienteConvenioHook.corrigeIdCliente = async (clienteConvenio) => {
  if (!clienteConvenio.tb_clientes_id) {
    const convenioDoCliente = await clienteConvenio.convenio().fetch()
    const convenioDoCliente_ = convenioDoCliente.toJSON()[0]
    clienteConvenio.tb_clientes_id = convenioDoCliente_?.cliente_padrao_id
  }
}

ClienteConvenioHook.corrigeIdClientes = async (clientesConvenio) => {
  await Promise.all(clientesConvenio.map(async (clienteConvenio, i) => {
    if (!clienteConvenio.tb_clientes_id) {
      const convenioDoCliente = await clienteConvenio.convenio().fetch()
      const convenioDoCliente_ = convenioDoCliente.toJSON()[0]
      clientesConvenio[i].tb_clientes_id = convenioDoCliente_?.cliente_padrao_id
    }
  }));
}
