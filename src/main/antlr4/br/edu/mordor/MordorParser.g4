parser grammar MordorParser;

options { tokenVocab=MordorLexer; }

//ESTRUTURA PRINCIPAL
programa
    : blocoLug declaracaoGlobal* declaracaoFuncaoOuProcedimento* blocoSetup blocoLoop EOF
    ;

blocoLug
    : HARDWARE IN LBRACE declaracaoRecurso* RBRACE
    ;

blocoSetup
    : SETUP IN LBRACE comandoSetup* RBRACE
    ;

blocoLoop
    : LOOP IN LBRACE comando* RBRACE
    ;

//DECLARAÇÕES GLOBAIS
declaracaoGlobal
    : declaracaoConstante
    | declaracaoVariavelGlobal
    ;

declaracaoConstante
    : CONST tipo ID ASSIGN expressao SEMI
    ;

declaracaoVariavelGlobal
    : tipo ID (ASSIGN expressao)? SEMI
    ;

//RECURSOS (HARDWARE)
declaracaoRecurso
    : tipoRecurso ID ASSIGN pino (COLON expressao)? SEMI
    ;

tipoRecurso
    : INPUT | OUTPUT | INPUT_PULLUP | ANALOG_INPUT | PWM_OUTPUT
    ;

pino
    : (DIGITAL_PIN | ANALOG_PIN) LPAREN INT_LITERAL RPAREN
    ;

//FUNÇÕES E PROCEDIMENTOS
declaracaoFuncaoOuProcedimento
    : declaracaoFuncao
    | declaracaoProcedimento
    ;

declaracaoFuncao
    : FUNCTION tipo ID LPAREN listaParametros? RPAREN bloco
    ;

declaracaoProcedimento
    : FUNCTION VOID ID LPAREN listaParametros? RPAREN bloco
    ;

listaParametros
    : parametro (COMMA parametro)*
    ;

parametro
    : (tipo | tipoRecurso) ID
    ;

//TIPOS
tipo
    : tipoBase (LT INT_LITERAL GT)?
    | TIME_TYPE (LT MILLIS GT)?
    | TEXT_TYPE
    | OPTIONAL_BYTE_TYPE
    | LBRACK tipoBase SEMI INT_LITERAL RBRACK
    ;

tipoBase
    : INT_TYPE
    | BYTE_TYPE
    | FLOAT
    | BOOL_TYPE
    | LEVEL_TYPE
    ;

//BLOCOS E COMANDOS
bloco
    : IN LBRACE comando* RBRACE
    ;

comandoSetup
    : SERIAL_BEGIN INT_LITERAL SEMI
    | comando
    ;

comando
    : declaracaoVariavelLocal
    | comandoAtribuicao
    | comandoAcao
    | comandoIf
    | comandoSwitch
    | comandoWhile
    | comandoFor
    | comandoDoWhile
    | comandoRepeat
    | comandoBreak
    | comandoContinue
    | comandoReturn
    ;

declaracaoVariavelLocal
    : CONST? tipo ID ASSIGN expressao SEMI
    ;

comandoAtribuicao
    : ID (LBRACK expressao RBRACK)? ASSIGN expressao SEMI
    ;

comandoAcao
    : ACTION acaoEspecifica SEMI
    ;

acaoEspecifica
    : (SERIAL_PRINT | SERIAL_PRINTLN | SERIAL_WRITE | DELAY) expressao
    | DIGITAL_WRITE expressao TO ID
    | ANALOG_WRITE ID expressao
    | chamada
    ;

comandoIf
    : IF expressao (TO ID)? bloco (ELSE bloco)?
    ;

comandoSwitch
    : SWITCH expressao IN LBRACE casoSwitch+ defaultSwitch? RBRACE
    ;

casoSwitch
    : CASE expressao bloco
    ;

defaultSwitch
    : ELSE bloco
    ;

comandoWhile
    : WHILE expressao bloco
    ;

comandoFor
    : FOR LPAREN inicializacaoFor? SEMI expressao? SEMI atualizacaoFor? RPAREN bloco
    ;

inicializacaoFor
    : tipo ID ASSIGN expressao
    | ID (LBRACK expressao RBRACK)? ASSIGN expressao
    | ACTION chamada
    ;

atualizacaoFor
    : ID (LBRACK expressao RBRACK)? ASSIGN expressao
    | ACTION chamada
    ;

comandoDoWhile
    : DO bloco WHILE expressao SEMI
    ;

comandoRepeat
    : REPEAT expressao bloco
    ;

comandoBreak
    : BREAK SEMI
    ;

comandoContinue
    : CONTINUE SEMI
    ;

comandoReturn
    : RETURN expressao? SEMI
    ;

chamada
    : ID LPAREN argumentos? RPAREN
    ;

argumentos
    : expressao (COMMA expressao)*
    ;

//EXPRESSÕES
expressao
    : expressaoOu
    ;

expressaoOu
    : expressaoE (OR expressaoE)*
    ;

expressaoE
    : expressaoIgualdade (AND expressaoIgualdade)*
    ;

expressaoIgualdade
    : expressaoRelacional ((EQ | NEQ) expressaoRelacional)?
    ;

expressaoRelacional
    : expressaoAditiva ((LT | LE | GT | GE) expressaoAditiva)?
    ;

expressaoAditiva
    : expressaoMultiplicativa ((PLUS | MINUS) expressaoMultiplicativa)*
    ;

expressaoMultiplicativa
    : expressaoUnaria ((STAR | SLASH | PERCENT) expressaoUnaria)*
    ;

expressaoUnaria
    : (NOT | MINUS) expressaoUnaria
    | expressaoPosFixa
    ;

expressaoPosFixa
    : expressaoPrimaria (LBRACK expressao RBRACK)*
    ;

expressaoPrimaria
    : INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
    | TRUE
    | FALSE
    | HIGH
    | LOW
    | chamada
    | ID
    | LPAREN expressao RPAREN
    | LBRACK expressao (COMMA expressao)* RBRACK
    | (tipoBase | FLOAT) LPAREN expressao RPAREN
    | TIME_TYPE LPAREN INT_LITERAL COMMA INT_LITERAL RPAREN
    | SERIAL_READ
    | MILLIS
    | (DIGITAL_READ | ANALOG_READ) ID
    | expressaoBit
    ;

expressaoBit
    : BIT_NOT LT INT_LITERAL GT LPAREN expressao RPAREN
    | (BIT_AND | BIT_OR | BIT_XOR | SHIFT_LEFT | SHIFT_RIGHT) LT INT_LITERAL GT LPAREN expressao COMMA expressao RPAREN
    ;