package Test::BDD::Cucumber::I18n;

=head1 NAME

Test::BDD::Cucumber::I18N - Internationalization

=head1 DESCRIPTION

Internationalization of feature files and step definitions.

=head1 SYNOPSIS

use Test::BDD::Cucumber::I18N qw(languages has_language langdef);

# get codes of supported languages
my @supported_languages = languages();

# look up if a language is supported
my $language_is_supported = has_language('de');

# get definition of a language
my $langdef = langdef('de');

=cut

use strict;
use warnings;

use Encode qw(encode);
use JSON::XS;
use utf8;

use base 'Exporter';

our @EXPORT_OK=qw(languages langdef has_language readable_keywords keyword_to_subname);

# Parse keywords hash for all supported languages from the DATA segment
my $json      = join '', (<DATA>);
my $json_utf8 = encode('UTF-8', $json);
my $langdefs  = decode_json( $json_utf8 );

sub languages {
    return keys $langdefs;
}

sub has_language {
    my ($language) = @_;
    exists $langdefs->{$language};
}

sub langdef {
    my ($language) = @_;

    return unless has_language($language);
    return $langdefs->{$language};
}

sub readable_keywords {
    my ($string, $transform)=@_;

    my @keywords= grep { $_ ne '[*]' } split(/\|/, $string);

    @keywords = map { $transform->($_) } @keywords if $transform;

    return join(', ', map { '"'.$_.'"' } @keywords);
}

sub keyword_to_subname {
    my ($word)=@_;

    # remove non-word characters so we have a decent sub name
    $word =~ s{[^\p{Word}]}{}g;

    return $word;
}

=head1 LANGUAGES

Languages are defined in a JSON-based hash in the __DATA__ section of this file.
That hash is based on the i18n.json of the Gherkin project (the parser for
features that the original Cucumber tool uses).

Gherkin can be found at L<https://github.com/cucumber/gherkin>,
its i18n.json at L<https://github.com/cucumber/gherkin/blob/master/lib/gherkin/i18n.json>.

=head1 AUTHOR

Gregor Goldbach C<glauschwuffel@nomaden.org>
(based on the works of Pablo Duboue)

=head1 LICENSE

Copyright 2014, Gregor Goldbach; Licensed under the same terms as Perl

Definition of languages based on data from Gherkin.
Copyright (c) 2009-2013 Mike Sassak, Gregory Hnatiuk, Aslak Hellesøy

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut

__DATA__
{
	"en": {
	  "name": "English",
	  "native": "English",
	  "feature": "Feature|Business Need|Ability",
	  "background": "Background",
	  "scenario": "Scenario",
	  "scenario_outline": "Scenario Outline|Scenario Template",
	  "examples": "Examples|Scenarios",
	  "given": "[*]|Given",
	  "when": "[*]|When",
	  "then": "[*]|Then",
	  "and": "[*]|And",
	  "but": "[*]|But"
	},
	"ar": {
	  "name": "Arabic",
	  "native": "العربية",
	  "feature": "خاصية",
	  "background": "الخلفية",
	  "scenario": "سيناريو",
	  "scenario_outline": "سيناريو مخطط",
	  "examples": "امثلة",
	  "given": "[*]|بفرض",
	  "when": "[*]|متى|عندما",
	  "then": "[*]|اذاً|ثم",
	  "and": "[*]|و",
	  "but": "[*]|لكن"
	},
	"bm": {
	  "name": "Malay",
	  "native": "Bahasa Melayu",
	  "feature": "Fungsi",
	  "background": "Latar Belakang",
	  "scenario": "Senario",
	  "scenario_outline": "Menggariskan Senario ",
	  "examples": "Contoh ",
	  "given": "[*]|Bagi",
	  "when": "[*]|Apabila",
	  "then": "[*]|Kemudian",
	  "and": "[*]|Dan",
	  "but": "[*]|Tetapi"
	},
	"bg": {
	  "name": "Bulgarian",
	  "native": "български",
	  "feature": "Функционалност",
	  "background": "Предистория",
	  "scenario": "Сценарий",
	  "scenario_outline": "Рамка на сценарий",
	  "examples": "Примери",
	  "given": "[*]|Дадено",
	  "when": "[*]|Когато",
	  "then": "[*]|То",
	  "and": "[*]|И",
	  "but": "[*]|Но"
	},
	"ca": {
	  "name": "Catalan",
	  "native": "català",
	  "background": "Rerefons|Antecedents",
	  "feature": "Característica|Funcionalitat",
	  "scenario": "Escenari",
	  "scenario_outline": "Esquema de l'escenari",
	  "examples": "Exemples",
	  "given": "[*]|Donat|Donada|Atès|Atesa",
	  "when": "[*]|Quan",
	  "then": "[*]|Aleshores|Cal",
	  "and": "[*]|I",
	  "but": "[*]|Però"
	},
	"cy-GB": {
	  "name": "Welsh",
	  "native": "Cymraeg",
	  "background": "Cefndir",
	  "feature": "Arwedd",
	  "scenario": "Scenario",
	  "scenario_outline": "Scenario Amlinellol",
	  "examples": "Enghreifftiau",
	  "given": "[*]|Anrhegedig a",
	  "when": "[*]|Pryd",
	  "then": "[*]|Yna",
	  "and": "[*]|A",
	  "but": "[*]|Ond"
	},
	"cs": {
	  "name": "Czech",
	  "native": "Česky",
	  "feature": "Požadavek",
	  "background": "Pozadí|Kontext",
	  "scenario": "Scénář",
	  "scenario_outline": "Náčrt Scénáře|Osnova scénáře",
	  "examples": "Příklady",
	  "given": "[*]|Pokud|Za předpokladu",
	  "when": "[*]|Když",
	  "then": "[*]|Pak",
	  "and": "[*]|A také|A",
	  "but": "[*]|Ale"
	},
	"da": {
	  "name": "Danish",
	  "native": "dansk",
	  "feature": "Egenskab",
	  "background": "Baggrund",
	  "scenario": "Scenarie",
	  "scenario_outline": "Abstrakt Scenario",
	  "examples": "Eksempler",
	  "given": "[*]|Givet",
	  "when": "[*]|Når",
	  "then": "[*]|Så",
	  "and": "[*]|Og",
	  "but": "[*]|Men"
	},
	"de": {
	  "name": "German",
	  "native": "Deutsch",
	  "feature": "Funktionalität",
	  "background": "Grundlage",
	  "scenario": "Szenario",
	  "scenario_outline": "Szenariogrundriss",
	  "examples": "Beispiele",
	  "given": "[*]|Angenommen|Gegeben sei",
	  "when": "[*]|Wenn",
	  "then": "[*]|Dann",
	  "and": "[*]|Und",
	  "but": "[*]|Aber"
	},
	"en-au": {
	  "name": "Australian",
	  "native": "Australian",
	  "feature": "Pretty much",
	  "background": "First off",
	  "scenario": "Awww, look mate",
	  "scenario_outline": "Reckon it's like",
	  "examples": "You'll wanna",
	  "given": "[*]|Y'know",
	  "when": "[*]|It's just unbelievable",
	  "then": "[*]|But at the end of the day I reckon",
	  "and": "[*]|Too right",
	  "but": "[*]|Yeah nah"
	},
	"en-lol": {
	  "name": "LOLCAT",
	  "native": "LOLCAT",
	  "feature": "OH HAI",
	  "background": "B4",
	  "scenario": "MISHUN",
	  "scenario_outline": "MISHUN SRSLY",
	  "examples": "EXAMPLZ",
	  "given": "[*]|I CAN HAZ",
	  "when": "[*]|WEN",
	  "then": "[*]|DEN",
	  "and": "[*]|AN",
	  "but": "[*]|BUT"
	},
	"en-pirate": {
	  "name": "Pirate",
	  "native": "Pirate",
	  "feature": "Ahoy matey!",
	  "background": "Yo-ho-ho",
	  "scenario": "Heave to",
	  "scenario_outline": "Shiver me timbers",
	  "examples": "Dead men tell no tales",
	  "given": "[*]|Gangway!",
	  "when": "[*]|Blimey!",
	  "then": "[*]|Let go and haul",
	  "and": "[*]|Aye",
	  "but": "[*]|Avast!"
	},
	"en-Scouse": {
	  "name": "Scouse",
	  "native": "Scouse",
	  "feature": "Feature",
	  "background": "Dis is what went down",
	  "scenario": "The thing of it is",
	  "scenario_outline": "Wharrimean is",
	  "examples": "Examples",
	  "given": "[*]|Givun|Youse know when youse got",
	  "when": "[*]|Wun|Youse know like when",
	  "then": "[*]|Dun|Den youse gotta",
	  "and": "[*]|An",
	  "but": "[*]|Buh"
	},
	"en-tx": {
	  "name": "Texan",
	  "native": "Texan",
	  "feature": "Feature",
	  "background": "Background",
	  "scenario": "Scenario",
	  "scenario_outline": "All y'all",
	  "examples": "Examples",
	  "given": "[*]|Given y'all",
	  "when": "[*]|When y'all",
	  "then": "[*]|Then y'all",
	  "and": "[*]|And y'all",
	  "but": "[*]|But y'all"
	},
	"eo": {
	  "name": "Esperanto",
	  "native": "Esperanto",
	  "feature": "Trajto",
	  "background": "Fono",
	  "scenario": "Scenaro",
	  "scenario_outline": "Konturo de la scenaro",
	  "examples": "Ekzemploj",
	  "given": "[*]|Donitaĵo",
	  "when": "[*]|Se",
	  "then": "[*]|Do",
	  "and": "[*]|Kaj",
	  "but": "[*]|Sed"
	},
	"es": {
	  "name": "Spanish",
	  "native": "español",
	  "background": "Antecedentes",
	  "feature": "Característica",
	  "scenario": "Escenario",
	  "scenario_outline": "Esquema del escenario",
	  "examples": "Ejemplos",
	  "given": "[*]|Dado|Dada|Dados|Dadas",
	  "when": "[*]|Cuando",
	  "then": "[*]|Entonces",
	  "and": "[*]|Y",
	  "but": "[*]|Pero"
	},
	"et": {
	  "name": "Estonian",
	  "native": "eesti keel",
	  "feature": "Omadus",
	  "background": "Taust",
	  "scenario": "Stsenaarium",
	  "scenario_outline": "Raamstsenaarium",
	  "examples": "Juhtumid",
	  "given": "[*]|Eeldades",
	  "when": "[*]|Kui",
	  "then": "[*]|Siis",
	  "and": "[*]|Ja",
	  "but": "[*]|Kuid"
	},
    "fa": {
        "name": "Persian",
        "native": "فارسی",
        "feature": "وِیژگی",
        "background": "زمینه",
        "scenario": "سناریو",
        "scenario_outline": "الگوی سناریو",
        "examples": "نمونه ها",
        "given": "[*]|با فرض",
        "when": "[*]|هنگامی",
        "then": "[*]|آنگاه",
        "and": "[*]|و",
        "but": "[*]|اما"
    },
	"fi": {
	  "name": "Finnish",
	  "native": "suomi",
	  "feature": "Ominaisuus",
	  "background": "Tausta",
	  "scenario": "Tapaus",
	  "scenario_outline": "Tapausaihio",
	  "examples": "Tapaukset",
	  "given": "[*]|Oletetaan",
	  "when": "[*]|Kun",
	  "then": "[*]|Niin",
	  "and": "[*]|Ja",
	  "but": "[*]|Mutta"
	},
	"fr": {
	  "name": "French",
	  "native": "français",
	  "feature": "Fonctionnalité",
	  "background": "Contexte",
	  "scenario": "Scénario",
	  "scenario_outline": "Plan du scénario|Plan du Scénario",
	  "examples": "Exemples",
	  "given": "[*]|Soit|Etant donné|Etant donnée|Etant donnés|Etant données|Étant donné|Étant donnée|Étant donnés|Étant données",
	  "when": "[*]|Quand|Lorsque|Lorsqu'<",
	  "then": "[*]|Alors",
	  "and": "[*]|Et",
	  "but": "[*]|Mais"
	},
	"he": {
	  "name": "Hebrew",
	  "native": "עברית",
	  "feature": "תכונה",
	  "background": "רקע",
	  "scenario": "תרחיש",
	  "scenario_outline": "תבנית תרחיש",
	  "examples": "דוגמאות",
	  "given": "[*]|בהינתן",
	  "when": "[*]|כאשר",
	  "then": "[*]|אז|אזי",
	  "and": "[*]|וגם",
	  "but": "[*]|אבל"
	},
	"hr": {
	  "name": "Croatian",
	  "native": "hrvatski",
	  "feature": "Osobina|Mogućnost|Mogucnost",
	  "background": "Pozadina",
	  "scenario": "Scenarij",
	  "scenario_outline": "Skica|Koncept",
	  "examples": "Primjeri|Scenariji",
	  "given": "[*]|Zadan|Zadani|Zadano",
	  "when": "[*]|Kada|Kad",
	  "then": "[*]|Onda",
	  "and": "[*]|I",
	  "but": "[*]|Ali"
	},
	"hu": {
	  "name": "Hungarian",
	  "native": "magyar",
	  "feature": "Jellemző",
	  "background": "Háttér",
	  "scenario": "Forgatókönyv",
	  "scenario_outline": "Forgatókönyv vázlat",
	  "examples": "Példák",
	  "given": "[*]|Amennyiben|Adott",
	  "when": "[*]|Majd|Ha|Amikor",
	  "then": "[*]|Akkor",
	  "and": "[*]|És",
	  "but": "[*]|De"
	},
	"id": {
	  "name": "Indonesian",
	  "native": "Bahasa Indonesia",
	  "feature": "Fitur",
	  "background": "Dasar",
	  "scenario": "Skenario",
	  "scenario_outline": "Skenario konsep",
	  "examples": "Contoh",
	  "given": "[*]|Dengan",
	  "when": "[*]|Ketika",
	  "then": "[*]|Maka",
	  "and": "[*]|Dan",
	  "but": "[*]|Tapi"
	},
	"is": {
	  "name": "Icelandic",
	  "native": "Íslenska",
	  "feature": "Eiginleiki",
	  "background": "Bakgrunnur",
	  "scenario": "Atburðarás",
	  "scenario_outline": "Lýsing Atburðarásar|Lýsing Dæma",
	  "examples": "Dæmi|Atburðarásir",
	  "given": "[*]|Ef",
	  "when": "[*]|Þegar",
	  "then": "[*]|Þá",
	  "and": "[*]|Og",
	  "but": "[*]|En"
	},
	"it": {
	  "name": "Italian",
	  "native": "italiano",
	  "feature": "Funzionalità",
	  "background": "Contesto",
	  "scenario": "Scenario",
	  "scenario_outline": "Schema dello scenario",
	  "examples": "Esempi",
	  "given": "[*]|Dato|Data|Dati|Date",
	  "when": "[*]|Quando",
	  "then": "[*]|Allora",
	  "and": "[*]|E",
	  "but": "[*]|Ma"
	},
	"ja": {
	  "name": "Japanese",
	  "native": "日本語",
	  "feature": "フィーチャ|機能",
	  "background": "背景",
	  "scenario": "シナリオ",
	  "scenario_outline": "シナリオアウトライン|シナリオテンプレート|テンプレ|シナリオテンプレ",
	  "examples": "例|サンプル",
	  "given": "[*]|前提<",
	  "when": "[*]|もし<",
	  "then": "[*]|ならば<",
	  "and": "[*]|かつ<",
	  "but": "[*]|しかし<|但し<|ただし<"
	},
	"ko": {
	  "name": "Korean",
	  "native": "한국어",
	  "background": "배경",
	  "feature": "기능",
	  "scenario": "시나리오",
	  "scenario_outline": "시나리오 개요",
	  "examples": "예",
	  "given": "[*]|조건<|먼저<",
	  "when": "[*]|만일<|만약<",
	  "then": "[*]|그러면<",
	  "and": "[*]|그리고<",
	  "but": "[*]|하지만<|단<"
	},
	"lt": {
	  "name": "Lithuanian",
	  "native": "lietuvių kalba",
	  "feature": "Savybė",
	  "background": "Kontekstas",
	  "scenario": "Scenarijus",
	  "scenario_outline": "Scenarijaus šablonas",
	  "examples": "Pavyzdžiai|Scenarijai|Variantai",
	  "given": "[*]|Duota",
	  "when": "[*]|Kai",
	  "then": "[*]|Tada",
	  "and": "[*]|Ir",
	  "but": "[*]|Bet"
	},
	"lu": {
	  "name": "Luxemburgish",
	  "native": "Lëtzebuergesch",
	  "feature": "Funktionalitéit",
	  "background": "Hannergrond",
	  "scenario": "Szenario",
	  "scenario_outline": "Plang vum Szenario",
	  "examples": "Beispiller",
	  "given": "[*]|ugeholl",
	  "when": "[*]|wann",
	  "then": "[*]|dann",
	  "and": "[*]|an|a",
	  "but": "[*]|awer|mä"
	},
	"lv": {
	  "name": "Latvian",
	  "native": "latviešu",
	  "feature": "Funkcionalitāte|Fīča",
	  "background": "Konteksts|Situācija",
	  "scenario": "Scenārijs",
	  "scenario_outline": "Scenārijs pēc parauga",
	  "examples": "Piemēri|Paraugs",
	  "given": "[*]|Kad",
	  "when": "[*]|Ja",
	  "then": "[*]|Tad",
	  "and": "[*]|Un",
	  "but": "[*]|Bet"
	},
	"nl": {
	  "name": "Dutch",
	  "native": "Nederlands",
	  "feature": "Functionaliteit",
	  "background": "Achtergrond",
	  "scenario": "Scenario",
	  "scenario_outline": "Abstract Scenario",
	  "examples": "Voorbeelden",
	  "given": "[*]|Gegeven|Stel",
	  "when": "[*]|Als",
	  "then": "[*]|Dan",
	  "and": "[*]|En",
	  "but": "[*]|Maar"
	},
	"no": {
	  "name": "Norwegian",
	  "native": "norsk",
	  "feature": "Egenskap",
	  "background": "Bakgrunn",
	  "scenario": "Scenario",
	  "scenario_outline": "Scenariomal|Abstrakt Scenario",
	  "examples": "Eksempler",
	  "given": "[*]|Gitt",
	  "when": "[*]|Når",
	  "then": "[*]|Så",
	  "and": "[*]|Og",
	  "but": "[*]|Men"
	},
	"pl": {
	  "name": "Polish",
	  "native": "polski",
	  "feature": "Właściwość|Funkcja|Aspekt|Potrzeba biznesowa",
	  "background": "Założenia",
	  "scenario": "Scenariusz",
	  "scenario_outline": "Szablon scenariusza",
	  "examples": "Przykłady",
	  "given": "[*]|Zakładając|Mając",
	  "when": "[*]|Jeżeli|Jeśli|Gdy|Kiedy",
	  "then": "[*]|Wtedy",
	  "and": "[*]|Oraz|I",
	  "but": "[*]|Ale"
	},
	"pt": {
	  "name": "Portuguese",
	  "native": "português",
	  "background": "Contexto|Cenário de Fundo|Cenario de Fundo|Fundo",
	  "feature": "Funcionalidade|Característica|Caracteristica",
	  "scenario": "Cenário|Cenario",
	  "scenario_outline": "Esquema do Cenário|Esquema do Cenario|Delineação do Cenário|Delineacao do Cenario",
	  "examples": "Exemplos|Cenários|Cenarios",
	  "given": "[*]|Dado|Dada|Dados|Dadas",
	  "when": "[*]|Quando",
	  "then": "[*]|Então|Entao",
	  "and": "[*]|E",
	  "but": "[*]|Mas"
	},
	"ro": {
	  "name": "Romanian",
	  "native": "română",
	  "background": "Context",
	  "feature": "Functionalitate|Funcționalitate|Funcţionalitate",
	  "scenario": "Scenariu",
	  "scenario_outline": "Structura scenariu|Structură scenariu",
	  "examples": "Exemple",
	  "given": "[*]|Date fiind|Dat fiind|Dati fiind|Dați fiind|Daţi fiind",
	  "when": "[*]|Cand|Când",
	  "then": "[*]|Atunci",
	  "and": "[*]|Si|Și|Şi",
	  "but": "[*]|Dar"
	},
	"ru": {
	  "name": "Russian",
	  "native": "русский",
	  "feature": "Функция|Функционал|Свойство",
	  "background": "Предыстория|Контекст",
	  "scenario": "Сценарий",
	  "scenario_outline": "Структура сценария",
	  "examples": "Примеры",
	  "given": "[*]|Допустим|Дано|Пусть",
	  "when": "[*]|Если|Когда",
	  "then": "[*]|То|Тогда",
	  "and": "[*]|И|К тому же|Также",
	  "but": "[*]|Но|А"
	},
	"sv": {
	  "name": "Swedish",
	  "native": "Svenska",
	  "feature": "Egenskap",
	  "background": "Bakgrund",
	  "scenario": "Scenario",
	  "scenario_outline": "Abstrakt Scenario|Scenariomall",
	  "examples": "Exempel",
	  "given": "[*]|Givet",
	  "when": "[*]|När",
	  "then": "[*]|Så",
	  "and": "[*]|Och",
	  "but": "[*]|Men"
	},
	"sk": {
	  "name": "Slovak",
	  "native": "Slovensky",
	  "feature": "Požiadavka",
	  "background": "Pozadie",
	  "scenario": "Scenár",
	  "scenario_outline": "Náčrt Scenáru",
	  "examples": "Príklady",
	  "given": "[*]|Pokiaľ",
	  "when": "[*]|Keď",
	  "then": "[*]|Tak",
	  "and": "[*]|A",
	  "but": "[*]|Ale"
	},
	"sr-Latn": {
	  "name": "Serbian (Latin)",
	  "native": "Srpski (Latinica)",
	  "feature": "Funkcionalnost|Mogućnost|Mogucnost|Osobina",
	  "background": "Kontekst|Osnova|Pozadina",
	  "scenario": "Scenario|Primer",
	  "scenario_outline": "Struktura scenarija|Skica|Koncept",
	  "examples": "Primeri|Scenariji",
	  "given": "[*]|Zadato|Zadate|Zatati",
	  "when": "[*]|Kada|Kad",
	  "then": "[*]|Onda",
	  "and": "[*]|I",
	  "but": "[*]|Ali"
	},
	"sr-Cyrl": {
	  "name": "Serbian",
	  "native": "Српски",
	  "feature": "Функционалност|Могућност|Особина",
	  "background": "Контекст|Основа|Позадина",
	  "scenario": "Сценарио|Пример",
	  "scenario_outline": "Структура сценарија|Скица|Концепт",
	  "examples": "Примери|Сценарији",
	  "given": "[*]|Задато|Задате|Задати",
	  "when": "[*]|Када|Кад",
	  "then": "[*]|Онда",
	  "and": "[*]|И",
	  "but": "[*]|Али"
	},
	"tr": {
	  "name": "Turkish",
	  "native": "Türkçe",
	  "feature": "Özellik",
	  "background": "Geçmiş",
	  "scenario": "Senaryo",
	  "scenario_outline": "Senaryo taslağı",
	  "examples": "Örnekler",
	  "given": "[*]|Diyelim ki",
	  "when": "[*]|Eğer ki",
	  "then": "[*]|O zaman",
	  "and": "[*]|Ve",
	  "but": "[*]|Fakat|Ama"
	},
	"uk": {
	  "name": "Ukrainian",
	  "native": "Українська",
	  "feature": "Функціонал",
	  "background": "Передумова",
	  "scenario": "Сценарій",
	  "scenario_outline": "Структура сценарію",
	  "examples": "Приклади",
	  "given": "[*]|Припустимо|Припустимо, що|Нехай|Дано",
	  "when": "[*]|Якщо|Коли",
	  "then": "[*]|То|Тоді",
	  "and": "[*]|І|А також|Та",
	  "but": "[*]|Але"
	},
	"uz": {
	  "name": "Uzbek",
	  "native": "Узбекча",
	  "feature": "Функционал",
	  "background": "Тарих",
	  "scenario": "Сценарий",
	  "scenario_outline": "Сценарий структураси",
	  "examples": "Мисоллар",
	  "given": "[*]|Агар",
	  "when": "[*]|Агар",
	  "then": "[*]|Унда",
	  "and": "[*]|Ва",
	  "but": "[*]|Лекин|Бирок|Аммо"
	},
	"vi": {
	  "name": "Vietnamese",
	  "native": "Tiếng Việt",
	  "feature": "Tính năng",
	  "background": "Bối cảnh",
	  "scenario": "Tình huống|Kịch bản",
	  "scenario_outline": "Khung tình huống|Khung kịch bản",
	  "examples": "Dữ liệu",
	  "given": "[*]|Biết|Cho",
	  "when": "[*]|Khi",
	  "then": "[*]|Thì",
	  "and": "[*]|Và",
	  "but": "[*]|Nhưng"
	},
	"zh-CN": {
	  "name": "Chinese simplified",
	  "native": "简体中文",
	  "feature": "功能",
	  "background": "背景",
	  "scenario": "场景|剧本",
	  "scenario_outline": "场景大纲|剧本大纲",
	  "examples": "例子",
	  "given": "[*]|假如<|假设<|假定<",
	  "when": "[*]|当<",
	  "then": "[*]|那么<",
	  "and": "[*]|而且<|并且<|同时<",
	  "but": "[*]|但是<"
	},
	"zh-TW": {
	  "name": "Chinese traditional",
	  "native": "繁體中文",
	  "feature": "功能",
	  "background": "背景",
	  "scenario": "場景|劇本",
	  "scenario_outline": "場景大綱|劇本大綱",
	  "examples": "例子",
	  "given": "[*]|假如<|假設<|假定<",
	  "when": "[*]|當<",
	  "then": "[*]|那麼<",
	  "and": "[*]|而且<|並且<|同時<",
	  "but": "[*]|但是<"
	}
}
