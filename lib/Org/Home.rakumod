unit class Home;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

sub code-note($s) {
    p( :style('font-size:small; text-align:right'), em("...$s") )
}
sub vignette(*@a, *%h) {
    grid :grid-template-columns<2.2fr 3.2fr>, :gap(1.5), |%h, @a
}
sub install {
    div [
        a :href</nav/1/install>, :target<_self>, button 'Install';
        p 'Linux, macOS, Windows';
    ];
}

class Buttabs does Tabs {
    #| custom button-tab style
    method STYLE {  q:to/END/;
        .tab-menu {
            display: block;
            justify-content: left;
        }
        .tab-links {
            display: block;
        }
        .tab-links > li > a {
            border-radius: var(--pico-border-radius);
            background-color: transparent;
            text-decoration: none;
            cursor: pointer;
            user-select: none;
        }
        .tab-links > li.active > a {
            text-decoration: none;
            border-bottom: var(--pico-border-width) solid var(--pico-primary-hover);
        }

        @media (max-width: 768px) {
            .tab-menu {
                text-align: center;
            }
            .tab-links > * {
                padding-top: 0;
                padding-bottom:1em;
            }
        }
        END
    }
}
sub buttabs(*@a, *%h) { Buttabs.new( |@a, |%h ) }

sub home-page(&basepage, &shadow) is export {
    basepage #:REFRESH(10),
        main [
            shadow;
            div :align<center>, [
                h1 safe 'Raku is an expressive, multi&#8209;paradigm, Open Source language that works the way you think.';
                spacer :height<16em>;
                install;
                spacer :height<16em>;
            ];

            div [
                buttabs [

                    multi-paradigm => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Multi Paradigm';
                                p 'Smoothly combine coding styles:';
                                ul [
                                    li( 'Object-Oriented:'; code 'class Circle'; 'encapsulates data and behavior.' );
                                    li( 'Functional: built-ins like'; code '.map'; 'and operators like'; code '».'; 'and'; code '[+]'; '.' );
                                    li( 'Declarative:'; code '...'; 'infers sequences, such as the powers of two.' );
                                    li( 'Procedural: the overall code flow is straightforward.' );
                                ];
                                code-note 'natural syntax & semantics';
                            ];
                            article [
                                hilite q:to/END/;
                                    class Circle {
                                        has $.radius;
                                        method area { π * $.radius² }
                                    }

                                    my @radii = 1,2,4...256;

                                    my @circles = map { Circle.new(:$^radius) }, @radii;

                                    my $total-area = [+] @circles».area;


                                    say "Total area: $total-area";
                                    END
                            ];
                        ];

                    strict-gradual => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Strict & Gradual Types';
                                p 'Introduce types as needed:';
                                ul [
                                    li( code 'Str $name'; 'and'; code 'Int $age'; 'enforce strict types.');
                                    li( code '$user'; 'and'; code '$info'; 'are dynamically typed.' );
                                    li( 'They work smoothly together ... gradual typing in action.' );
                                ];
                                code-note 'rapid prototype to solid product';
                            ];
                            article [
                                hilite q:to/END/;
                                    sub greet(Str $name) {      # Strictly typed
                                        say "Hello, $name!"
                                    }
                                    my $user = "Alice";         # Untyped (dynamic)
                                    greet($user);               # Works fine

                                    my Int $age = 30;           # Strict Int
                                    my $info = "Age: $age";     # Dynamic string interpolation
                                    say $info;
                                    END
                            ];
                        ];

                    interactive-mode => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Interactive Mode';
                                p 'Experienced programmers in any other language can pick up raku very quickly, and beginners find the REPL (Read-Evaluate-Print-Loop) a great way to interactively explore.';
                                code-note 'makes the easy things easy';
                            ];
                            article [
                                hilite q:to/END/;
                                    # Output, quoting
                                    say "Hello, I'm raku!";
                                    #Hello, I'm raku!

                                    # Input, assignment
                                    my $name = prompt "What is your name?";
                                    #What is your name? [Dave]

                                    # Interpolation
                                    say "I'm sorry, $name. I'm afraid I can't do that.😔";
                                    #I'm sorry, Dave. I'm afraid I can't do that.😔
                                    END
                                ];
                        ];

                    command-line => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Command Line';
                                p 'Create your own command line function:';
                                ul [
                                    li( 'Positional arguments like ('; code '$name'; ') are required by default.');
                                    li( 'Named arguments like (', code ':$age'; ' and '; code ':$verbose'; ') are optional.' );
                                    li( 'Boolean flags like ', code '--verbose'; ' are automatically treated as True if present.' );
                                ];
                                code-note 'with automated --help';
                            ];
                            article [
                                hilite q:to/END/;
                                    #!/usr/bin/env raku
                                    sub MAIN(Str $name, Int :$age = 0, Bool :$verbose) {
                                        say "Hello, $name!";

                                        say "You are $age years old." if $age > 0;
                                        say "This is a verbose greeting." if $verbose;
                                    }

                                    # ./greet Alice --age=30 --verbose
                                    END
                                ];
                        ];


                    thriving-ecosystem => tab  #iamerejh
                        vignette :direction<rtl>, [
                            article [
                                h3 'Thriving Ecosystem';
                                p ['The'; code 'zef'; 'package manager and '; code 'raku.land'; 'directory provide a unified framework for specifying and installing modules.'];
                                p 'Built in semantic version literals and smart compare for wildcard (*) and minimum (+) versions.';
                                p 'Revision-gated compiler selection underpins the durability of your code.';
                                code-note 'robust package management';
                            ];
                            article [

                                hilite q:to/END/;
                                    # Lock the compiler to v6.d for compatibility
                                    use v6.d;

                                    # Use API 1 from version 2.1 or later (any minor release)
                                    use Physics::Measure:api<1>:ver<2.1+.*>:auth<zef:alice> :ALL;

                                    say 42m / 10s;   # 42m/s
                                    END
                                ];
                        ];

                    one-liners => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'One Liners';
                                p 'Use on the command line for more ergonomic scripts.';
                                p ['An'; code 'awk'; 'alternative, for example.'];
                                code-note 'bash, sed, awk alternative';
                            ];
                            article [
                                hilite q:to/END/;
                                    raku -ne 'say s:g/foo/bar/' file.txt
                                    # subst all "foo" with "bar"

                                    raku -pe 's/ (\d+) / {flip($0)} /' file.txt
                                    # flip digit runs
                                    # 123 to 321  (western)
                                    # ٣٢٥ to ٥٢٣  (urdu)
                                    END
                                ];
                        ];
                ];

                buttabs [
                    grammars => tab
                        vignette [
                            article [
                                h3 'Grammars';
                                p  'Definable grammars for pattern matching and generalized string processing.';
                                code-note 'domain specific languages';
                            ];
                            article [
                                hilite q:to/END/;
                                    grammar Parser {
                                        rule  TOP  { I <love> <lang> }
                                        token love { '♥' | love }
                                        token lang { < Raku Rust Go Python Ruby TypeScript PHP > }
                                    }

                                    say Parser.parse: 'I ♥ Raku';
                                    # OUTPUT: ｢I ♥ Raku｣ love => ｢♥｣ lang => ｢Raku｣

                                    say Parser.parse: 'I love Python';
                                    # OUTPUT: ｢I love Python｣ love => ｢love｣ lang => ｢Python｣
                                    END
                                ];
                        ];


                    concurrency => tab
                        vignette [
                            article [
                                h3 'Concurrency';
                                p  'Parallelism, concurrency, and asynchrony including multi-core support.';
                                code-note 'exploit latest hardware';
                            ];
                            article [
                                hilite q:to/END/;
                                    start { sleep 1.5; print "hi" }
                                    await Supply.from-list(<A B C D E F>).throttle: 2, {
                                        sleep 0.5;
                                        .print
                                    }
                                    # OUTPUT: ABCDhiEF'
                                    END
                                ];
                        ];

                    lazy-evaluation => tab
                        vignette [
                            article [
                                h3 'Lazy Evaluation';
                                p  'Functional programming primitives, lazy and eager list evaluation.';
                                code-note 'memory & processor efficient';
                            ];
                            article [
                                hilite q:to/END/;
                                    # Infinite list of primes:
                                    my @primes = ^∞ .grep: *.is-prime;
                                    say "1001ˢᵗ prime is @primes[1000]";

                                    # Lazily read words from a file:
                                    .say for '50TB.file.txt'.IO.words;
                                    END
                                ];
                        ];

                    role-composition => tab
                        vignette [
                            article [
                                h3 'Role Composition';
                                p 'Here\'s a Bird class that inherits from Animal and composes the Flyer role. It shows a child method overriding the parent and usage of both inherited and composed behavior.';
                                code-note 'Python simplicity with C++ power';
                            ];
                            article [
                                hilite q:to/END/;
                                    role Flyer { method fly { say "I'm flying!" } }

                                    class Animal { method speak { say "Some sound" } }

                                    class Bird is Animal does Flyer {
                                        method speak { say "Chirp!" }
                                    }

                                    Bird.new.speak;  # Chirp!
                                    Bird.new.fly;    # I'm flying!
                                    END
                                ];
                        ];

                    mixins => tab
                        vignette [
                            article [
                                h3 'Mixins';
                                p 'This shows an instance of the Int (arbitrary precision integer) class with a stringification method mixed in via the but. The say routine stringifies the variable and so returns "forty two".';
                                code-note 'everything is an object';
                            ];
                            article [
                                hilite q:to/END/;
                                    my Int $i = 42 but 'forty two';

                                    say $i;   # OUPUT <<forty two>>
                                    END
                                ];
                        ];

                    multi-dispatch => tab
                        vignette [
                            article [
                                h3 'Multi-Dispatch';
                                p [ 'Multi subs and methods help streamline code such as this Fibonacci generator. [Or, in this case, you could use the '; code '...'; ' Sequence operator.]' ];
                                code-note 'cleaner, more extensible code';
                            ];
                            article [
                                hilite q:to/END/;
                                    proto fib (Int $n --> Int) {*}
                                    multi fib (0)  { 0 }
                                    multi fib (1)  { 1 }
                                    multi fib ($n) { fib($n - 1) + fib($n - 2) }
                                    # -or-
                                    my @fib = 0, 1, *+* ... *;
                                    END
                                ];
                        ];

                    signatures => tab
                        vignette [
                            article [
                                h3 'Signatures';
                                p 'The signature syntax simplifies function definitions with clear parameter handling and built-in type checks';
                                p 'See if you can spot positional (@) and named (%) args, optonal(?) [and mandatory(!)] args, slurpy parameters (*), slips (|), type defined-ness (:D), type coercion (()), return types (-->) and aliases (:f)';
                                code-note 'finely tuned interfaces';
                            ];
                            article [
                                hilite q:to/END/;
                                    sub outer(*@a, *%h) {
                                        inner(|@a, |%h);
                                    }

                                    sub inner(Int:D $x=0, Num(Rat) $y?, Bool :f(:$flag) --> Str) {
                                        "$x, $y, flag is $flag";
                                    }

                                    say outer(1, 0.1, :f);    #  1, 0.1, flag is True
                                    END
                                ];
                        ];

                    io => tab
                        vignette [
                            article [
                                h3 'File IO';
                                p 'Changes the first occurrence of "Hello" to "Hi" in the file.';
                                p [code '.IO.lines'; ' and '; code '.IO.words'; 'return a lazy list of the file lines or words. This batch pipelined model makes light work of enormous files'];
                                code-note 'well designed abstractions';
                            ];
                            article [
                                hilite q:to/END/;
                                    my $content = "example.txt".IO.slurp;       # Read file

                                    $content ~~ s/Hello/Hi/;                    # Modify content

                                    spurt $filename, $content;                  # Write back to file
                                    END
                                ];
                        ];

                ];

                buttabs [
                    unicode-regexes => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Unicode Regexes';
                                p  'Arguably the most powerful Unicode-aware regular expression engine available, especially for complex text processing.';
                                p 'It shines in tasks where precision and multilingual support are essential such as Grapheme and Diacritic handling.';
                                code-note 'unicode centric text handling';
                            ];
                            article [
                                hilite q:to/END/;
                                    say "Cool😎" ~~ /<:Letter>* <:Block("Emoticons")>/; # ｢Cool😎｣
                                    say "Cześć" ~~ m:ignoremark/ Czesc /;               # ｢Cześć｣
                                    say "WEIẞE" ~~ m:ignorecase/ weisse /;              # ｢WEIẞE｣
                                    say "หนูแฮมสเตอร์" ~~ /<:Letter>+/;                   # ｢หนูแฮมสเตอร์｣
                                    END
                            ];
                        ];

                    hyper-operators => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Hyper Operators';
                                p  'Smart and consistent operator modifiers that apply parallel code execution and vector processing.';
                                code-note 'easy parallel processing';
                            ];
                            article [
                                hilite q:to/END/;
                                    my @nums = [1,2,3];

                                    say @nums »+» 10;       # (11 12 13)            [Hyper]
                                    say [+] @nums;          # 6                     [Reduce]
                                    say @nums X* 2, 4;      # ((2 4) (4 8) (6 12))  [Cross]
                                    END
                                ];
                        ];

                    feed-operators => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Feed Operators';
                                ul [
                                    li( code '(1..5)'; 'creates a Range.' );
                                    li( code 'map'; 'doubles each value.' );
                                    li( code 'grep'; 'filters value greater than 5.' );
                                    li( code 'say'; 'outputs the results.' );
                                ];
                                code-note 'function pipelines';
                            ];
                            article [
                                hilite q:to/END/;
                                    # pipeline functional style
                                    (1..5)
                                        ==> map { $_ * 2 }
                                        ==> grep { $_ > 5 }
                                        ==> say();              # (6 8 10)

                                    # method chain OO style
                                    (1..5)
                                        .map( * * 2)
                                        .grep( * > 5)
                                        .say                    # (6 8 10)
                                    END
                                ];
                        ];

                    rational-numerics => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Rational Numerics';
                                p  'Int, BigInt, Rational (fraction), Complex & Num (floating point) numbers all come as standard.';
                                p  ['Prevents floating-point errors by using exact math, so'; code '0.1 + 0.2 == 0.3'; 'just works.'];
                                code-note 'math without surprises';
                            ];
                            article [
                                hilite q:to/END/;
                                    # standard numeric types
                                    say 2 ** 64;                    # Int
                                    say 2 ** 64 + 1;                # BigInt
                                    say (1/13 + 3/7 + 3/8).raku;    # Rat <641/728>
                                    say 3+4i;                       # Complex
                                    say 5e0;                        # Num

                                    # no floating point error
                                    say 0.1 + 0.2 == 0.3;           # True
                                    END
                                ];
                        ];

                    sets-junctions => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Sets & Junctions';
                                p 'Set, Bag and Mix come with all the set operators: ∪ ∩ ∆ ⊖ ∖ ∈ ∉ ⊆ ⊂ ⊇ ⊃>.';
                                p 'Junctions (any, all, one, none) simplify multi-value tests for clean declarative logic.';
                                code-note 'more concise code';
                            ];
                            article [
                                hilite q:to/END/;
                                    my $colors = set <red green blue>;
                                    say 'blue' ∈ $colors;        # True

                                    my $fruit = any <apple banana cherry>;
                                    say so $fruit eq 'banana';   # True

                                    say so 5 > (1 & 2 & 3);      # True
                                    END
                                ];
                        ];

                    smartmatching => tab
                        vignette :direction<rtl>, [
                            article [
                                h3 'Smartmatching';
                                p [ 'The '; code 'given { when }'; ' construct uses smartmatching ('; code('~~'); ') to check type, equality, membership, logic, regex and so on.'; ];
                                code-note 'powerful matcher capability';
                            ];
                            article [
                                hilite q:to/END/;
                                my $value = 42;

                                given $value {
                                    when * %% 7    { say "Divisible by 7" }
                                    when Int       { say "It's an integer!" }
                                    when 42        { say "The answer to everything!" }
                                    when 1..10     { say "Between 1 and 10" }
                                    when /\d ** 2/ { say "Has two digits" }
                                    default        { say "Something else" }
                                }
                                END
                            ];
                        ];
                ];
            ];

            buttabs [
                L10N => tab
                    vignette [
                        article [
                            h3 'Localization & Internationalization';
                            p 'This snippet is written using Japanese identifiers and strings, showcasing localization (L10N) and internationalization (I18N) features.';
                            p 'Localized Raku code can be automatically translated to any other localization.';
                            code-note 'think global: act local';
                        ];
                        article [
                            hilite q:to/END/;
                                私の $数 = プロンプト "数を教えてください ";
                                言う "数は{$数}です。";

                                もしも $数 <= 10 {
                                    言う "数は10以下です";
                                } その他 {
                                    言う "数は10以上です";
                                }
                                END
                            ];
                    ];

                FFI => tab
                    vignette [
                        article [
                            h3 'FFI (Foreign Function Interface)';
                            p 'Call functions or use data from libraries written in another language — often C or C++.';
                            code-note 'reuse code and improve performance';
                        ];
                        article [
                            hilite q:to/END/;
                                use NativeCall;

                                sub abs(int32 --> int32) is native('c') { * }

                                say abs(-42);  # Outputs: 42
                                END
                            ];
                    ];

                LLM => tab
                    vignette [
                        article [
                            h3 'LLM Functions';
                            p 'A suite of LLM and Data modules. Define functions with metadata to automate LLMs like ChatGPT. Connect user prompts to code, making AI-driven interfaces easier to build.';
                            code-note 'connect LLMs to code';
                        ];
                        article [
                            hilite q:to/END/;
                                use LLM::Functions;

                                my &recipe = llm-function(
                                    -> :$dish, :$cuisine { "Recipe for $dish in $cuisine cuisine."},
                                    llm-evaluator => 'chatGPT'
                                );

                                say recipe(dish => 'salad', cuisine => 'Russian');

                                # **Ingredients:**
                                #
                                # * 1 head of cabbage (chopped)
                                # * 2 carrots (grated)
                                # ...
                                END
                            ];
                    ];

                Cro => tab
                    vignette [
                        article [
                            h3 'Distributed Web Services';
                            p 'Starts an HTTP server on ', code 'localhost:10000';
                            p 'Responds to:';
                            ul [
                                li( code '/'; 'with '; em '"Hello Cro!".');
                                li( code '/hello'; ' with '; em '"Hello World!".');
                                li( code '/greet/<name>'; ' with a personalized greeting, e.g. '; em '"Hello, Alice!"');
                            ];
                            p 'Stops gracefully with Ctrl+C (', code 'SIGINT', ')';
                            code-note 'pluggable middleware and Cro template language';
                        ];
                        article [
                            hilite q:to/END/;
                                use Cro::HTTP::Router;
                                use Cro::HTTP::Server;

                                my $application = route {
                                    get -> {
                                        content 'text/plain', 'Hello, Cro!';
                                    }
                                    get -> 'hello' {
                                        content 'text/plain', 'Hello, World!';
                                    }
                                    get -> 'greet', $name {
                                        content 'text/plain', "Hello, $name!";
                                    }
                                };

                                my Cro::HTTP::Server $server .= new:
                                    :host<localhost>,
                                    :port(10000),
                                    :$application;
                                $server.start;
                                react whenever signal(SIGINT) {
                                    $server.stop;
                                    exit;
                                }
                                END
                            ];
                    ];

                Red => tab
                    vignette [
                        article [
                            h3 'Object Relational Mapper (ORM)';
                            p 'Here we use Red to define a Person model with fields id, firstName, and lastName. It sets up a SQLite database, creates a corresponding table, and populates it with data from a json-data() function. The ^populate method takes model data from JSON and inserts it into the database.';
                            code-note 'declarative table definitions';
                        ];
                        article [
                            hilite q:to/END/;
                                use Red:api<2>;
                                red-defaults “SQLite”;

                                model Person {
                                    has Int      $.id         is serial;
                                    has Str      $.firstName  is column;
                                    has Str      $.lastName   is column;

                                    method ^populate($model) {
                                        for json-data() -> %record {
                                            $model.^create(|%record);
                                        }
                                    }
                                }

                                Person.^create-table;
                                Person.^populate;
                                END
                            ];
                    ];

            ];

            div :align<center>, :style<min-width:400px;>, [
                spacer :min-height<4em>;
                install;
                spacer :min-height<4em>;
            ];
        ];
}
