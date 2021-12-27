defmodule SumList do
  def call(list), do: sum(list, 0)

  # def call_enum(list), do: Enum.map(list, fn elem -> elem + 1 end)
  # O Enum.sum  faz o papel de somar os valores em uma lista
  # Enum.max retorna o maior.
  # Enum.min retorna o menor.
  # Enum.map primeiro argumento é a lista o segundo é a função que vamos usar para fazer algo com nossos valores
  # Enum.any? retorna um boolean
  # Enum.map(%{a: 1, b: 2}, fn {_chave, valor} -> valor end)

  def call_enum(list), do: Enum.any?(list, fn elem -> elem > 5 end)

  defp sum([], acc), do: acc
  # se a função for de uma linha pode usar o do: e tirar o end
  defp sum([head | tail], acc) do
    acc = acc + head
    # IO.inspect(tail) mesma função do console.log
    sum(tail, acc)
  end
end

# [1,2,3], 0

# 1 ex:[1,2,3] hd: 1, tail [2,3], 0 -> acc = 0 + 1, sum([2,3], 1)
# 2 ex:[2,3] hd: 2, tail [3], 1 -> acc = 1 + 2, sum([3], 3)
# 3 ex:[3] hd: 3, tail [], 3 -> acc = 3 + 3, sum([], 6)
# 4 ex:[],  acc = 6
