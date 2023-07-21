menu = """
========== MENU ==========

   Escolha uma opção:

     [d] = Depositar

     [s] = Sacar

     [e] = Extrato

     [q] = Sair

==========================
"""

saldo = 0
limite = 500
extrato = ""
numero_de_saques = 0
LIMITE_DE_SAQUES = 3

while True:

    opcao = input(menu)
    
    if opcao == "d":
        valor = float(input("Qual o valor a ser depositado? R$"))
       
        if valor > 0:
            saldo += valor
            print(f"Depósito realizado com sucesso! Seu novo saldo é R${saldo}")
            extrato += f"Depósito - R$ {valor:.2f}\n"
        
        else:
            print("Falha na operação! O valor não é válido.")
   
   
    elif opcao == "s":
        valor = float(input("Qual o valor a ser sacado? R$"))
        
        excedeu_saldo = valor > saldo

        excedeu_limite = valor > limite

        excedeu_saques = numero_de_saques >= LIMITE_DE_SAQUES
        
        if excedeu_saldo:
            print("Erro! Saldo insuficiente!") 
            
        elif excedeu_limite:
            print("Erro! Seu limite de saque é inferior ao solicitado")
        
        elif excedeu_saques:
            print("Erro! Você excedeu o número de saques para hoje!")
        
        elif valor > 0:
            saldo -= valor
            extrato += f"Saque - R$ {valor:.2f}\n"
            numero_de_saques += 1
            print(f"Retire seu dinheiro! Seu novo saldo é R${saldo}")
        
        else:
            print("Operação falhou! Valor informado é inválido.")

    elif opcao == "e":
        print("\n============= EXTRATO =============")
        print("Não foram realizadas movimentações.") if not extrato else extrato
        print(extrato)
        print(f"\nSaldo: R${saldo:.2f}")
        print("=====================================")
    
    elif opcao == "q":
        break

    else:
        print("Operação inválida, por favor selecione novamente a operação desejada!")