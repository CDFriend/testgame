CP=cp -av
RM=rm
MKDIR=mkdir -p

BUILD_DIR=build
LIB_DEST_DIR=$(BUILD_DIR)/lib
INCLUDE_DEST_DIR=$(BUILD_DIR)/include

LIBS=libsdl2
CLEANLIBS=$(addsuffix _clean, $(LIBS))

# "Alias" library targets to their .done files
$(foreach TARGET,$(LIBS),$(TARGET): .$(TARGET)_done)

all: $(LIBS)
clean: $(CLEANLIBS)

###############################################################################
# libsdl2
###############################################################################
LIBSDL2_SRC_DIR=ext/sdl2

.libsdl2_done: $(BUILD_DIR)
	cd $(LIBSDL2_SRC_DIR); ./configure
	$(MAKE) -C $(LIBSDL2_SRC_DIR)
	$(CP) $(LIBSDL2_SRC_DIR)/include $(INCLUDE_DEST_DIR)/sdl2
	$(CP) $(LIBSDL2_SRC_DIR)/build/libSDL2.la $(LIB_DEST_DIR)/libsdl2.a
	touch $@

libsdl2_clean:
	$(MAKE) -C $(LIBSDL2_SRC_DIR) clean
	$(RM) .libsdl2-done

$(BUILD_DIR): $(INCLUDE_DEST_DIR) $(LIB_DEST_DIR)
$(INCLUDE_DEST_DIR):
	$(MKDIR) $(INCLUDE_DEST_DIR)
$(LIB_DEST_DIR):
	$(MKDIR) $(LIB_DEST_DIR)
