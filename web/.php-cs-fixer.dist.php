<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = Finder::create()
    ->notPath('bootstrap/cache')
    ->notPath('storage')
    ->notPath('vendor')
    ->notPath('node_modules')
    ->in(__DIR__)
    ->name('*.php')
    ->notName('*.blade.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

$rules = [
    '@PSR12' => true,
    'array_indentation' => true,
    'array_syntax' => ['syntax' => 'short'],
    'binary_operator_spaces' => [
        'operators' => [
            '='  => 'single_space',
            '=>' => 'align_single_space_minimal',
        ],
    ],
    'blank_line_after_namespace' => true,
    'blank_line_after_opening_tag' => true,
    'blank_line_before_statement' => [
        'statements' =>  [
            'break',
            'continue',
            'declare',
            'return',
            'throw',
            'try',
            'if',
            'for',
            'foreach',
        ],
    ],
    'blank_lines_before_namespace' => true,
    'cast_spaces' => true,
    'class_attributes_separation' => [
        'elements' => [
            'const' => 'one',
            'method' => 'one',
            'property' => 'one',
            'trait_import' => 'none',
        ],
    ],
    'concat_space' => [
        'spacing' => 'one',
    ],
    'constant_case' => ['case' => 'lower'],
    'echo_tag_syntax' => false,
    'encoding' => true,
    'fully_qualified_strict_types' => true,
    'increment_style' => ['style' => 'pre'],
    'linebreak_after_opening_tag' => true,
    'list_syntax' => true,
    'multiline_whitespace_before_semicolons' => false,
    'new_with_parentheses' => false,
    'no_mixed_echo_print' => [
        'use' => 'echo',
    ],
    'no_multiline_whitespace_around_double_arrow' => true,
    'not_operator_with_successor_space' => true,
    'no_short_bool_cast' => true,
    'no_unneeded_control_parentheses' => [
        'statements' => [
            'break',
            'clone',
            'continue',
            'echo_print',
            'return',
            'switch_case',
            'yield',
        ],
    ],
    'no_unset_cast' => true,
    'no_unused_imports' => true,
    'no_useless_else' => true,
    'no_useless_return' => true,
    'not_operator_with_successor_space' => true,
    'ordered_class_elements' => [
        'order' => [
            'use_trait',
            'constant_public',
            'constant_protected',
            'constant_private',
            'property_public',
            'property_protected',
            'property_private',
            'construct',
            'destruct',
            'magic',
            'phpunit',
            'method_protected_static',
            'method_public',
            'method_protected',
            'method_private',
        ],
        'sort_algorithm' => 'none',
    ],
    'ordered_imports' => [
        'imports_order' => [
            'class',
            'function',
            'const',
        ],
        'sort_algorithm' => 'length',
    ],
    'phpdoc_add_missing_param_annotation' => ['only_untyped' => true],
    'phpdoc_indent' => true,
    'phpdoc_no_package' => true,
    'phpdoc_order' => true,
    'phpdoc_scalar' => true,
    'phpdoc_separation' => true,
    'phpdoc_single_line_var_spacing' => true,
    'phpdoc_trim' => true,
    'phpdoc_types' => true,
    'phpdoc_var_without_name' => true,
    'phpdoc_to_comment' => true,
    'php_unit_method_casing' => ['case' => 'snake_case'],
    'return_type_declaration' => ['space_before' => 'one'],
    'short_scalar_cast' => true,
    'simplified_null_return' => true,
    'single_line_after_imports' => true,
    'single_quote' => true,
    'standardize_not_equals' => true,
    'trailing_comma_in_multiline' => true,
    'trim_array_spaces' => true,
    'unary_operator_spaces' => true,
];

return (new Config)
    ->setRules($rules)
    ->setFinder($finder)
    ->setUsingCache(true);
