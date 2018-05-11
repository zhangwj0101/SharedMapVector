LOCAL_BASE	:= unitTest/TEST_PAYLOAD
LOCAL_MDLS	:=
LOCAL_BLDS	:= $(addprefix $(LOCAL_BASE)/, $(LOCAL_MDLS))
LOCAL_INCS	:= $(wildcard $(INCLUDE_DIRS)/$(LOCAL_MDLS)/*.h)

LOCAL_SRCS	:= $(wildcard $(LOCAL_BASE)/*.cpp)
LOCAL_SRCS	+= $(foreach sdir, $(LOCAL_BLDS), $(wildcard $(sdir)/*.cpp))

LOCAL_OBJS	:= $(patsubst %.cpp, %.o, $(LOCAL_SRCS))
LOCAL_DEPS	:= $(patsubst %.cpp, %.deps, $(LOCAL_SRCS))

SRCS		+= $(LOCAL_SRCS)
OBJS		+= $(LOCAL_OBJS)
DEPS		+= $(LOCAL_DEPS)

$(LOCAL_DEPS): $(LOCAL_SRCS) $(LOCAL_INCS)
	@$(CXX) -MM $< > $@

$(LOCAL_OBJS): $(LOCAL_SRCS) $(LOCAL_DEPS)


