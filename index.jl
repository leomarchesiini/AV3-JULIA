function define_decimals(n)
    if n ≤ 5
        return 1
    elseif n ≤ 10
        return 2
    else
        return 4
    end
end

function generate_line(n, digits)
    line = rand(n)
    line /= sum(line)
    line = round.(line, digits=digits)

    for i in 1:n
        if line[i] < 0
            line[i] = 0.0
        end
    end

    add = sum(line)
    if add == 0
        line .= round(1/n, digits=digits)
        line[end] += 1.0 - sum(line)
    else
        line /= add
        line = round.(line, digits=digits)
        line[end] += 1.0 - sum(line)
    end

    return line
end

function matriz_transaction(n, digits)
    matriz = zeros(Float64, n, n)
    for i in 1:n
        matriz[i, :] = generate_line(n, digits)
    end
    return matriz
end

function show_matriz(matriz, show_digits)
    n = size(matriz, 1)
    for i in 1:n
        formated_line = [round(x, digits=show_digits) for x in matriz[i, :]]
        println(formated_line)
    end
end

function iniciating_markov_chain()
    println("Quantas linhas e colunas você deseja?")
    n = parse(Int, readline())
    digits = define_decimals(n)
    show_digits = min(digits, 4)  # limitar exibição a no máximo 4 casas

    println("\nUsando $digits casas decimais para cálculo e até $show_digits para exibição.")
    println("\nGerando matriz de transição aleatória...")
    matriz = matriz_transaction(n, digits)

    println("\nMatriz de transição:")
    show_matriz(matriz, show_digits)

    println("\nDigite o estado inicial (de 1 até $n):")
    current_state = parse(Int, readline())

    println("Quantos passos deseja simular?")
    passos = parse(Int, readline())

    println("\n--- Simulação ---")
    for i in 1:passos
        r = rand()
        println("Número aleatório gerado no passo $i: ", round(r, digits=show_digits))
        acumulado = 0.0
        for j in 1:n
            acumulado += matriz[current_state, j]
            if r <= acumulado
                current_state = j
                println("Estado no passo $i: $current_state")
                break
            end
        end
    end

    println("\nEstado final após $passos passos: $current_state")
end

iniciating_markov_chain()