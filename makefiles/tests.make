# ------------------------------------------------------------------------------------------------
# tests

TESTS_SOURCES := $(wildcard $(TESTS_DIR)/*.c)
TESTS_OBJECTS := $(patsubst %, $(BUILD_TESTS_DIR)/%, $(notdir $(TESTS_SOURCES:.c=.o)))
TESTS_TARGETS := $(patsubst %, $(BUILD_TESTS_DIR)/%, $(notdir $(TESTS_OBJECTS:.o=)))

run_tests:
	@echo "$(RED) run tests:$(NC)"
	$(foreach test, $(TESTS_TARGETS), \
          $(test) | grep "FAIL"; \
          echo "$(GREEN) TEST $(test)$(NC)";)	
	
build_tests: $(TESTS_TARGETS)

$(BUILD_TESTS_DIR)/% : $(BUILD_TESTS_DIR)/%.o
	@echo "$(RED)Linking $@ $(NC)"
	$(CC) $(CC_CFLAGS) -o $@ $^ $(SRC_OBJECTS) $(CC_LDFLAGS)

$(BUILD_TESTS_DIR)/%.o : $(TESTS_DIR)/%.c
	@echo "$(RED)Compiling $< $(NC)"
	$(CC) $(CC_CFLAGS) -c $< -o $@

