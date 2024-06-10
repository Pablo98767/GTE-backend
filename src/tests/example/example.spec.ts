import { test } from 'vitest'

/*
  Três itens são indispensáveis nos testes:

  1) Texto descrevendo o que está sendo testado;
  2) Código que executa a funcionalidade;
  3) Verificação do resultado obtido.
*/

test('exemplo de como criar testes', () => {
  const number = 1;

  expect(number + 1).toBe(2)
})