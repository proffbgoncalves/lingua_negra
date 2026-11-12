lexer grammar MordorLexer;

// Seções principais e estrutura
HARDWARE: 'lûg';
SETUP: 'ash_durb';
LOOP: 'durbatulûk';
CONST: 'krimp';
FUNCTION: 'durb';
RETURN: 'thrakul';
IN: 'ishi';

// Tipos de dados
INT_TYPE: 'ashum';
BYTE_TYPE: 'ashuk';
BOOL_TYPE: 'ashburz';
LEVEL_TYPE: 'burzash';
TIME_TYPE: 'nazgum';
TEXT_TYPE: 'nazg_ul';
OPTIONAL_BYTE_TYPE: 'ashuk_burz';
VOID: 'durb_burz';
FLOAT: 'ashum_nazg';

// Literais booleanos e de nível lógico
TRUE: 'ash';
FALSE: 'burzum';
HIGH: 'burz_ash';
LOW: 'búrz';

// Controle de fluxo
IF: 'gimb';
ELSE: 'gimb_burz';
SWITCH: 'gimbul';
CASE: 'gimb_ash';
WHILE: 'durb_gimb';
REPEAT: 'durb_ash';
DO: 'durb_at';
FOR: 'durb_nazg';
BREAK: 'krimp_durb';
CONTINUE: 'thrak_durb';

// Operadores lógicos
AND: 'agh';
OR: 'agh_ash';
NOT: 'agh_burz';

// Comandos de hardware e serial
ACTION: 'thrak';
TO: 'ul';
DIGITAL_WRITE: 'thrak_burzash';
ANALOG_WRITE: 'thrak_ashuk';
DELAY: 'krimp_nazg';
DIGITAL_READ: 'gimb_burzash';
ANALOG_READ: 'gimb_ashum';
SERIAL_PRINT: 'thrak_nazg';
SERIAL_PRINTLN: 'thrak_nazgul';
SERIAL_WRITE: 'thrak_ash';
SERIAL_BEGIN: 'ash_nazg';
SERIAL_READ: 'gimbatul';
MILLIS: 'gimb_nazgum';
DIGITAL_PIN: 'nazg';
ANALOG_PIN: 'nazg_ashum';
INPUT: 'gimbat';
INPUT_PULLUP: 'gimbat_ash';
OUTPUT: 'thrakat';
ANALOG_INPUT: 'gimbat_ashum';
PWM_OUTPUT: 'thrakat_ashuk';

// Operações bit a bit
BIT_AND: 'aghuk';
BIT_OR: 'aghuk_ash';
BIT_XOR: 'aghuk_burz';
BIT_NOT: 'burzuk';
SHIFT_LEFT: 'thrakuk';
SHIFT_RIGHT: 'gimbuk';

// Símbolos e operadores
EQ: '==';
NEQ: '!=';
LE: '<=';
GE: '>=';
ASSIGN: '=';
LT: '<';
GT: '>';
PLUS: '+';
MINUS: '-';
STAR: '*';
SLASH: '/';
PERCENT: '%';
COLON: ':';
SEMI: ';';
COMMA: ',';
LPAREN: '('; RPAREN: ')';
LBRACE: '{'; RBRACE: '}';
LBRACK: '['; RBRACK: ']';

// Literais, identificadores e comentários
FLOAT_LITERAL: DECIMAL ('.' DIGIT+ EXPONENT? | EXPONENT);
INT_LITERAL: '0b' [01]+ | '0x' [0-9a-fA-F]+ | DECIMAL;
STRING_LITERAL: '"' (ESCAPE | ~["\\\r\n])* '"';
ID: [a-zA-Z_] [a-zA-Z0-9_]*;

LINE_COMMENT: '//' ~[\r\n]* -> skip;
BLOCK_COMMENT: '/*' .*? '*/' -> skip;
WS: [ \t\r\n]+ -> skip;

fragment DECIMAL: '0' | [1-9] DIGIT*;
fragment DIGIT: [0-9];
fragment EXPONENT: [eE] [+-]? DIGIT+;
fragment ESCAPE: '\\' [nrt"\\];