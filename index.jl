function run_simulation()
    println("Insira a quantidade de Estados que sua matriz vai conter")
    num_states = parse(Int, readline())

    # Matriz de Transição
    transition_matrix = zeros(Float64, num_states, num_states)
    for row in 1:num_states
        while true
            println("Insira os $num_states valores para a linha $row, separados por espaço")
            input_line = split(readline())
            if length(input_line) != num_states
                println("Erro: Por favor insira exatamente os $num_states valores")
                continue
            end
            row_values = [parse(Float64, v) for v in input_line]
            if abs(sum(row_values) - 1.0) > 1e-6
                println("Erro: A soma tem que ser 1", sum(row_values))
                continue
            end
            transition_matrix[row, :] = row_values
            break
        end
    end

    # Distribuição Inicial
    println("\nInsira as probabilidades inicias para cada $num_states estados, separados por espaço")
    initial_distribution = zeros(Float64, num_states)
    while true
        input_line = split(readline())
        if length(input_line) != num_states
            println("Erro: Por favor insira exatamente os $num_states valores.")
            continue
        end
        initial_distribution = permutedims([parse(Float64, v) for v in input_line])
        if abs(sum(initial_distribution) - 1.0) > 1e-6
            println("Erro: a soma das probabilidades deve ser 1", sum(initial_distribution))
            continue
        end
        break
    end

    # Número de Interações
    println("\nQuantas interações você deseja simular?")
    input_iterations = readline()
    iterations = isempty(input_iterations) ? 100 : parse(Int, input_iterations)

    # Iniciar Simulação
    for _ in 1:iterations
        initial_distribution = initial_distribution * transition_matrix
    end

    println("\nVetor probabilidade depois de $iterations interações:")
    for state in 1:num_states
        println("Probabilidade do Estado 1 $state: ", round(initial_distribution[state] * 100, digits=2), "%")
    end
end

run_simulation()
