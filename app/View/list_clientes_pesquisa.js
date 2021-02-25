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

  const clienteView = {
    id,
    nome,
    num_cartao,
    id_convenio,
    cpf,
    id_convenio,
    convenio_cartao,
    tipo_cadastro: (id_convenio ? 'FIDELIDADE + CONVÊNIO' : 'FIDELIDADE'),
    convenio_principal_funcionario: (
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

function view_convenio_funcionario(convenioFuncionario) {
  let { cliente, empresa, ...convenio_funcionario_ } = convenioFuncionario

  cliente = (cliente || {})
  cliente.nome = (cliente?.nome || convenioFuncionario.funnomfun)
  cliente.cpf = (cliente?.cpf || convenioFuncionario.funcpffun)
  cliente.id_convenio = (cliente?.id_convenio || convenioFuncionario.ai)

  cliente.convenios_funcionario = [convenio_funcionario_]
  cliente.convenios_funcionario[0].empresa = empresa

  const retorno = view_cliente_fidelidade(cliente)

  retorno.tipo_cadastro = (cliente?.id ? 'FIDELIDADE + CONVÊNIO' : 'CONVÊNIO')

  return retorno
}

module.exports = {
  render(cliente, tipoPesquisa, debug = false) {
    if (debug || !cliente || !tipoPesquisa) {
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
        //view_convenio
        case 'Convenio Funcionario':
          retorno = view_convenio_funcionario(cliente)
          return retorno

        default:
          console.log('default')
          return cliente
      }
    } catch (err) {
      console.log('erro list_clientes_pesquisa')
      console.log(err.message)
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
