if exists("b:current_syntax")
  finish
endif

" Comment contained keywords
syntax keyword huffTodos contained TODO XXX FIXME NOTE
hi link huffTodos Todo

" comment
syn region huffComment start="//" end="$"
syn region huffComment start="/\*" end="\*/"
hi link huffComment Comment

" natspec
syn match huffNatspecTag "\v\@title>" contained
syn match huffNatspecTag "\v\@author>" contained
syn match huffNatspecTag "\v\@notice>" contained
syn match huffNatspecTag "\v\@dev>" contained
syn match huffNatspecTag "\v\@param>" contained
syn match huffNatspecTag "\v\@return>" contained
syn region huffNatspec start="/\*\*" end="\*/" contains=huffNatspecTag
syn region huffNatspec start="///" end="$" contains=huffNatspecTag
hi def link huffNatspecTag Keyword

" import
syn match huffInclude "\v#include>"
hi def link huffInclude Include

" constants
" number literal
syn match huffNumberDecimal "\v<\d+(\.\d+)?>"
syn match huffNumberHex "\v<0[xX][a-fA-F0-9]+>"
hi def link huffNumberDecimal Constant
hi def link huffNumberHex Constant
" Labels
syntax match huffLabel "^\i*:$"
highlight link huffLabel Type

" define
syn match huffDefine '#define' contained
syn keyword huffMacro macro contained
syn keyword huffFn fn contained
syn keyword huffJumptable jumptable contained
syn keyword huffJumptablePacked jumptable__packed contained
syn keyword huffError error contained
syn keyword huffFunction function contained
syn keyword huffEvent event contained
syn keyword huffConstant constant contained
syn keyword huffTakes takes contained
syn keyword huffReturns returns contained
hi def link huffDefine Define
hi def link huffMacro Keyword
hi def link huffFn Keyword
hi def link huffJumptable Keyword
hi def link huffJumptablePacked Keyword
hi def link huffError Keyword
hi def link huffFunction Keyword
hi def link huffEvent Keyword
hi def link huffConstant Keyword
hi def link huffTakes Keyword
hi def link huffReturns Keyword

syn match huffIdentifier "\v\i" contained
hi def link huffIdentifier Constant

syn match huffInterfacePrimitives "\v<(address|string\d*|bytes\d*|int\d*|uint\d*|bool|hash\d*)>" contained
hi def link huffInterfacePrimitives Type

syn match huffDeclMacro "\v#define\s+macro\s+\i+\s*\((\i+(,\s*\i+)*)?\)\s*\=\s*takes\s*\(\d+\)\s*returns\s*\(\d+\)" transparent contains=huffDefine,huffMacro,huffIdentifier,huffTakes,huffReturns
syn match huffDeclFn "\v#define\s+fn\s+\i+\s*\((\i+(,\s*\i+)*)?\)\s*\=\s*takes\s*\(\d+\)\s*returns\s*\(\d+\)" transparent contains=huffDefine,huffFn,huffIdentifier,huffTakes,huffReturns
syn match huffDeclJumptable "\v#define\s+jumptable(__packed)?\s+\i+>" transparent contains=huffDefine,huffJumtable,huffJumptablePacked,huffIdentifier
syn match huffConstantDef "\v#define\s+constant\s+[A-Za-z_]\w*" transparent contains=huffDefine,huffConstant,huffIdentifier,huffTakes,huffReturns
syn match huffDefError "\v#define\s+error\s+\i+>" transparent contains=huffDefine,huffError,huffIdentifier
syn match huffInterfaceFunction "\v#define\s+function\s+\i+\(.*\)" transparent contains=huffDefine,huffFunction,huffIdentifier,huffInterfacePrimitives
syn match huffInterfaceEvent "\v#define\s+event\s+\i+\(.*\)" transparent contains=huffDefine,huffEvent,huffIdentifier,huffInterfacePrimitives

" opcodes
" Environment opcodes
syn keyword huffEnvOpcode
	\ address 
	\ balance 
	\ origin
	\ caller
	\ callvalue
	\ calldataload
	\ calldatasize
	\ calldatacopy
	\ codesize
	\ codecopy
	\ gasprice
	\ returndatasize
	\ returndatacopy
	\ blockhash
	\ coinbase
	\ timestamp
	\ number
	\ difficulty
	\ gaslimit
	\ chainid
	\ selfbalance
	\ basefee
hi link huffEnvOpcode Special

" Trie opcodes
syn keyword huffTrieOpcode
	\ extcodesize
	\ extcodecopy
	\ extcodehash
	\ sload
	\ sstore
	\ selfdestruct
hi link huffTrieOpcode Special

" Call opcodes
syn keyword huffCallOpcode
	\ create
	\ call
	\ callcode
	\ delegatecall
	\ create2
	\ staticcall
hi link huffCallOpcode Special

" Push opcodes
syn match huffRegularOpcode
	\ "\<push\(3[1-2]\|[1-9]\|[1-2][0-9]\)\>"
	\ nextgroup=huffNumberDecimal,huffNumberHex
	\ skipwhite

" Regular opcodes
syntax match huffRegularOpcode "\<swap\(1[0-6]\|[1-9]\)\>"
syntax match huffRegularOpcode "\<dup\(1[0-6]\|[1-9]\)\>"
syntax match huffRegularOpcode "\<log\([0-4]\)\>"

syntax keyword huffRegularOpcode
	\ stop
	\ add
	\ mul
	\ sub
	\ div
	\ sdiv
	\ mod
	\ smod
	\ addmod
	\ mulmod
	\ exp
	\ signextend
	\ lt
	\ gt
	\ slt
	\ sgt
	\ eq
	\ iszero
	\ and
	\ or
	\ xor
	\ not
	\ byte
	\ shl
	\ shr
	\ sar
	\ keccak256
	\ pop
	\ mload
	\ mstore
	\ mstore8
	\ jump
	\ jumpi
	\ pc
	\ msize
	\ gas
	\ jumpdest
	\ revert
	\ invalid
	\ return
hi link huffRegularOpcode Statement

syn match huffTemplateCall "\v\<\s*\i+\s*\>" transparent contains=huffIdentifier
syn match huffConstantRef "\v\[[A-Z_]+\]" transparent contains=huffIdentifier

if get(g:, 'huff_fold_enable', 1)
  syn region huffBlock start="{" end="}" transparent fold
endif

let b:current_syntax = "huff"
