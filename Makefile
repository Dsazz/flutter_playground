ROOT := $(shell git rev-parse --show-toplevel)
FLUTTER := flutter

.PHONY: analyze
analyze:
	$(FLUTTER) analyze

.PHONY: format
format:
	$(FLUTTER) format lib

.PHONY: test
test:
	$(FLUTTER) test

.PHONY: extr-l10n
extr-l10n:
	$(FLUTTER) pub pub run intl_translation:extract_to_arb \
	--output-dir=lib/l10n \
	lib/lang/l10n.dart

.PHONY: gen-l10n
gen-l10n:
	$(FLUTTER) pub pub run intl_translation:generate_from_arb \
	--output-dir=lib/l10n \
	--no-use-deferred-loading \
	lib/lang/l10n.dart lib/l10n/intl_*.arb

.PHONY: l10n
l10n: extr-l10n gen-l10n