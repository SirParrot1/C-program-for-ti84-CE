# ----------------------------
# Build CE programs from the repo root.
#   make               build every project
#   make partial_frac  build one project
#   make clean         clean every project
# A project is any folder in "CE programs" with a makefile.
# ----------------------------

PROJECTS := $(shell cd "CE programs" && for d in */; do [ -f "$$d/makefile" ] && echo "$${d%/}"; done)

all: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C "CE programs/$@"

clean:
	@for p in $(PROJECTS); do $(MAKE) -C "CE programs/$$p" clean; done

.PHONY: all clean $(PROJECTS)
