LOCAL_BASE	:= lib
LOCAL_MDLS	:= 
LOCAL_BLDS	:= $(addprefix $(LOCAL_BASE)/, $(LOCAL_MDLS))

LOCAL_INCS	:= $(wildcard $(INCLUDE_DIRS)/$(LOCAL_MDLS)/*.h)

LOCAL_SRCS	:= $(wildcard $(LOCAL_BASE)/*.cpp)
LOCAL_SRCS	+= $(foreach sdir, $(LOCAL_BLDS), $(wildcard $(sdir)/*.cpp))

LOCAL_OBJS	:= $(patsubst %.cpp, %.o, $(LOCAL_SRCS))
LOCAL_DEPS	:= $(patsubst %.cpp, %.deps, $(LOCAL_SRCS))

SRCS		+= $(LOCAL_SRCS)
DEPS		+= $(LOCAL_DEPS)
TMPS		+= $(LOCAL_OBJS)
LIBS		+= $(LOCAL_LIBS)

$(LOCAL_DEPS): $(LOCAL_SRCS) $(LOCAL_INCS)
	@$(CXX) -MM $< > $@
	@$(CXX) $< -MM -MT $@ >> $@

$(LOCAL_OBJS): $(LOCAL_SRCS) $(LOCAL_DEPS)

$(LOCAL_LIBS): $(LOCAL_OBJS)
	$(AR) $(ARFLAGS) $@ $<
	

