function view_cliente_fidelidade(cliente) {
  const {
    id,
    nome,
    num_cartao,
    id_convenio,
    cpf,
    convenio_cartao,
    convenios_funcionario,
  } = cliente

  const { empresa } = convenios_funcionario[0]

  const clienteView = {
    id,
    nome,
    num_cartao,
    id_convenio,
    cpf,
    id_convenio,
    convenio_cartao,
    tipo_cadastro: (id_convenio ? 'FIDELIDADE + CONVÊNIO' : 'FIDELIDADE'),
    convenio_funcionario_principal: (
      convenios_funcionario?.filter(conven => conven.ai === id_convenio)
        .map(conven => {
          return {
            id: conven?.ai,
            ativo: (
              conven?.funfladem
                ? (
                  conven.funfladem === 'Z' &&
                  !conven.empresa?.empempcan &&
                  !conven.empresa?.empcanper
                )
                : false
            ),
            empresa: {
              id: conven.empresa?.empcodemp,
              razao_social: conven.empresa?.emprazsoc,
            }
          }
        }))[0],
    convenios_funcionario: (
      convenios_funcionario?.map(conven => {
        return {
          id: conven?.ai,
          ativo: (
            conven?.funfladem
              ? (
                conven.funfladem === 'Z' &&
                !conven.empresa?.empempcan &&
                !conven.empresa?.empcanper
              )
              : false
          ),
          empresa: {
            id: conven.empresa?.empcodemp,
            razao_social: conven.empresa?.emprazsoc,
          }
        }
      })
    )
  }

  return clienteView
}

module.exports = {
  render(cliente, tipoPesquisa) {
    if (!cliente || !tipoPesquisa) {
      return cliente
    }

    let retorno = cliente

    try {
      switch (tipoPesquisa) {
        case 'CPF':
          retorno = view_cliente_fidelidade(cliente)
          return retorno
        case 'Nome':
          retorno = view_cliente_fidelidade(cliente)
          return retorno
        case 'Convenio':
        //view_convenio_funcionado
        case 'Convenio Funcionario':
        //view_convenio_funcionado

        default:
          console.log('teste0')
          return cliente
      }
    } catch (err) {
      console.log('teste')
      return cliente
    }
  },

  renderMany(clientes, tipoPesquisa) {
    if (clientes && tipoPesquisa) {
      return clientes.map((cliente) => this.render(cliente, tipoPesquisa));
    }

    return clientes
  },
}
