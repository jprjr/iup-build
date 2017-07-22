mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
.PHONY: clean-lua clean-zlib clean-freetype clean-ftgl clean-im clean-cd clean-iup libim-all libcd-all libiup-all

LUA_VER         ?= 5.3.4
LUA_SFX         ?=       # if using LuaJIT, set to 'jit'
ZLIB_VER        ?= 1.2.8
FREETYPE_VER    ?= 2.6.3
FTGL_VER        ?= 2.1.5
IM_VER          ?= 3.12
CD_VER          ?= 5.11.1
IUP_VER         ?= 3.22
X11_VER         ?= 1.6.5
XPROTO_VER      ?= 7.0.31
XEXTPROTO_VER   ?= 7.3.0
GLPROTO_VER     ?= 1.4.17
DRI2PROTO_VER   ?= 2.8
KBPROTO_VER     ?= 1.0.7
INPUTPROTO_VER  ?= 2.3.2
RENDERPROTO_VER ?= 0.11.1
XTRANS_VER      ?= 1.3.5
LIBXCB_VER      ?= 1.12
LIBXAU_VER      ?= 1.0.8
LIBXEXT_VER     ?= 1.3.3
MESA_VER        ?= 17.1.5
GLU_VER         ?= 9.0.0
LIBDRM_VER      ?= 2.4.82
EXPAT_VER       ?= 2.2.2
FONTCONFIG_VER  ?= 2.12.4
XRENDER_VER     ?= 0.9.10
XFT_VER         ?= 2.3.2
XMU_VER         ?= 1.1.2
XPM_VER         ?= 3.5.12
XT_VER          ?= 1.1.5
SM_VER          ?= 1.2.2
ICE_VER         ?= 1.0.9
#MOTIF_VER       ?= 0.95.2
MOTIF_VER       ?= 2.3.7

TARGET         ?= i686-w64-mingw32
TARGET_CC      ?= $(TARGET)-gcc
TARGET_CXX     ?= $(TARGET)-g++
TARGET_AR      ?= $(TARGET)-ar
TARGET_NM      ?= $(TARGET)-nm
TARGET_LD      ?= $(TARGET)-g++
TARGET_AR      ?= $(TARGET)-ar
TARGET_RANLIB  ?= $(TARGET)-ranlib
TARGET_STRIP   ?= $(TARGET)-strip
TARGET_WINDRES ?= $(TARGET)-windres

# No need to set anything else!


SF_SITE = https://downloads.sourceforge.net/project/
CD_SITE = $(SF_SITE)canvasdraw/$(CD_VER)/Docs%20and%20Sources
IM_SITE = $(SF_SITE)imtoolkit/$(IM_VER)/Docs%20and%20Sources/
IUP_SITE = $(SF_SITE)iup/$(IUP_VER)/Docs%20and%20Sources/
ZLIB_SITE = $(IUP_SITE)
FTGL_SITE = $(IUP_SITE)
FREETYPE_SITE = $(IUP_SITE)
LUA_SITE = https://www.lua.org/ftp/
XORG_SITE = https://xorg.freedesktop.org/releases/individual/
X11_SITE = $(XORG_SITE)lib
XTRANS_SITE = $(XORG_SITE)lib
LIBXAU_SITE = $(XORG_SITE)lib
LIBXEXT_SITE = $(XORG_SITE)lib
XPROTO_SITE = $(XORG_SITE)proto
XEXTPROTO_SITE = $(XORG_SITE)proto
GLPROTO_SITE = $(XORG_SITE)proto
DRI2PROTO_SITE = $(XORG_SITE)proto
KBPROTO_SITE = $(XORG_SITE)proto
INPUTPROTO_SITE = $(XORG_SITE)proto
RENDERPROTO_SITE = $(XORG_SITE)proto
LIBXCB_SITE = https://xcb.freedesktop.org/dist/
MESA_SITE = https://mesa.freedesktop.org/archive/
GLU_SITE = ftp://ftp.freedesktop.org/pub/mesa/glu/
LIBDRM_SITE = https://dri.freedesktop.org/libdrm/
EXPAT_SITE = http://downloads.sourceforge.net/sourceforge/expat/
FONTCONFIG_SITE = https://www.freedesktop.org/software/fontconfig/release/
XRENDER_SITE = $(XORG_SITE)lib
XFT_SITE = $(XORG_SITE)lib
XPM_SITE = $(XORG_SITE)lib
XMU_SITE = $(XORG_SITE)lib
XT_SITE = $(XORG_SITE)lib
SM_SITE = $(XORG_SITE)lib
ICE_SITE = $(XORG_SITE)lib
#MOTIF_SITE = http://downloads.sourceforge.net/lesstif/
MOTIF_SITE = https://downloads.sourceforge.net/project/motif/Motif%202.3.7%20Source%20Code/

LUA_DLLVER := $(shell echo $(LUA_VER) | cut -f 1-2 -d '.' | sed 's/\.//')

TARGET_LIBEXT =
TARGET_EXEEXT =

TEC_SYSNAME =
TEC_SYSNAME_LC =
TEC_UNAME =
USE_GTK=
GTK_DEFAULT=
NO_GTK_DEFAULT=Yes
USE_GTK3=
USE_X11=
USE_XRENDER=
USE_GDK=
USE_MOTIF=

ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
TARGET_LIBEXT = dll
TARGET_EXEEXT = .exe
ifneq (,$(findstring x86_64,$(TARGET))) #begin win64
TEC_SYSNAME=Win64
TEC_SYSNAME_LC=win64
TEC_UNAME=mingw4_64
else
TEC_SYSNAME=Win32
TEC_SYSNAME_LC=win32
TEC_UNAME=mingw4
endif #end win64
else
ifneq (,$(findstring linux,$(TARGET))) #begin linux
TARGET_LIBEXT = so
TARGET_EXEEXT = ''
TEC_SYSNAME=Linux44
USE_X11=Yes
USE_XRENDER=Yes
USE_MOTIF=Yes
ifneq (,$(findstring x64_64,$(TARGET))) #begin linux64
TEC_UNAME=Linux44_64
else
ifneq (,$(findstring arm,$(TARGET))) #begin linuxarm
TEC_UNAME=Linux44_arm
endif #end linuxarm
TEC_UNAME=Linux44_x86
endif #end linux64
endif #end linux
endif #end windows


DEPSDIR = $(current_dir)deps
PATCHDIR = $(current_dir)patches

ZLIB_TARBALL        = $(DEPSDIR)/zlib-$(ZLIB_VER)_$(IUP_VER)_Sources.tar.gz
FTGL_TARBALL        = $(DEPSDIR)/ftgl-$(FTGL_VER)_$(IUP_VER)_Sources.tar.gz
FREETYPE_TARBALL    = $(DEPSDIR)/freetype-$(FREETYPE_VER)_$(IUP_VER)_Sources.tar.gz
CD_TARBALL          = $(DEPSDIR)/cd-$(CD_VER)_Sources.tar.gz
IM_TARBALL          = $(DEPSDIR)/im-$(IM_VER)_Sources.tar.gz
IUP_TARBALL         = $(DEPSDIR)/iup-$(IUP_VER)_Sources.tar.gz
LUA_TARBALL         = $(DEPSDIR)/lua-$(LUA_VER).tar.gz
LIBX11_TARBALL      = $(DEPSDIR)/libX11-$(X11_VER).tar.bz2
LIBXCB_TARBALL      = $(DEPSDIR)/libxcb-$(LIBXCB_VER).tar.bz2
LIBXAU_TARBALL      = $(DEPSDIR)/libXau-$(LIBXAU_VER).tar.bz2
LIBXEXT_TARBALL     = $(DEPSDIR)/libXext-$(LIBXEXT_VER).tar.bz2
XPROTO_TARBALL      = $(DEPSDIR)/xproto-$(XPROTO_VER).tar.bz2
XEXTPROTO_TARBALL   = $(DEPSDIR)/xextproto-$(XEXTPROTO_VER).tar.bz2
GLPROTO_TARBALL     = $(DEPSDIR)/glproto-$(GLPROTO_VER).tar.bz2
DRI2PROTO_TARBALL   = $(DEPSDIR)/dri2proto-$(DRI2PROTO_VER).tar.bz2
KBPROTO_TARBALL     = $(DEPSDIR)/kbproto-$(KBPROTO_VER).tar.bz2
INPUTPROTO_TARBALL  = $(DEPSDIR)/inputproto-$(INPUTPROTO_VER).tar.bz2
RENDERPROTO_TARBALL  = $(DEPSDIR)/renderproto-$(RENDERPROTO_VER).tar.bz2
XTRANS_TARBALL      = $(DEPSDIR)/xtrans-$(XTRANS_VER).tar.bz2
MESA_TARBALL        = $(DEPSDIR)/mesa-$(MESA_VER).tar.xz
GLU_TARBALL         = $(DEPSDIR)/glu-$(GLU_VER).tar.bz2
LIBDRM_TARBALL      = $(DEPSDIR)/libdrm-$(LIBDRM_VER).tar.bz2
EXPAT_TARBALL       = $(DEPSDIR)/expat-$(EXPAT_VER).tar.bz2
FONTCONFIG_TARBALL  = $(DEPSDIR)/fontconfig-$(FONTCONFIG_VER).tar.bz2
XRENDER_TARBALL     = $(DEPSDIR)/libXrender-$(XRENDER_VER).tar.bz2
XFT_TARBALL         = $(DEPSDIR)/libXft-$(XFT_VER).tar.bz2
XT_TARBALL         = $(DEPSDIR)/libXt-$(XT_VER).tar.bz2
XPM_TARBALL         = $(DEPSDIR)/libXpm-$(XPM_VER).tar.bz2
XMU_TARBALL         = $(DEPSDIR)/libXmu-$(XMU_VER).tar.bz2
SM_TARBALL         = $(DEPSDIR)/libSM-$(SM_VER).tar.bz2
ICE_TARBALL         = $(DEPSDIR)/libICE-$(ICE_VER).tar.bz2
MOTIF_TARBALL       = $(DEPSDIR)/motif-$(MOTIF_VER).tar.gz

ZLIB         := $(DEPSDIR)/zlib-$(ZLIB_VER)
FREETYPE     := $(DEPSDIR)/freetype-$(FREETYPE_VER)
FTGL         := $(DEPSDIR)/ftgl-$(FTGL_VER)
IM           := $(DEPSDIR)/im-$(IM_VER)
CD           := $(DEPSDIR)/cd-$(CD_VER)
IUP          := $(DEPSDIR)/iup-$(IUP_VER)
LUA          := $(DEPSDIR)/lua-$(LUA_VER)
LIBX11       := $(DEPSDIR)/libX11-$(X11_VER)
LIBXCB       := $(DEPSDIR)/libxcb-$(LIBXCB_VER)
LIBXAU       := $(DEPSDIR)/libXau-$(LIBXAU_VER)
LIBXEXT      := $(DEPSDIR)/libXext-$(LIBXEXT_VER)
XPROTO       := $(DEPSDIR)/xproto-$(XPROTO_VER)
XEXTPROTO    := $(DEPSDIR)/xextproto-$(XEXTPROTO_VER)
GLPROTO      := $(DEPSDIR)/glproto-$(GLPROTO_VER)
DRI2PROTO    := $(DEPSDIR)/dri2proto-$(DRI2PROTO_VER)
KBPROTO      := $(DEPSDIR)/kbproto-$(KBPROTO_VER)
INPUTPROTO   := $(DEPSDIR)/inputproto-$(INPUTPROTO_VER)
RENDERPROTO   := $(DEPSDIR)/renderproto-$(RENDERPROTO_VER)
XTRANS       := $(DEPSDIR)/xtrans-$(XTRANS_VER)
MESA         := $(DEPSDIR)/mesa-$(MESA_VER)
GLU          := $(DEPSDIR)/glu-$(GLU_VER)
LIBDRM       := $(DEPSDIR)/libdrm-$(LIBDRM_VER)
X11          := $(DEPSDIR)/x11
EXPAT        := $(DEPSDIR)/expat-$(EXPAT_VER)
FONTCONFIG   := $(DEPSDIR)/fontconfig-$(FONTCONFIG_VER)
XRENDER      := $(DEPSDIR)/libXrender-$(XRENDER_VER)
XFT          := $(DEPSDIR)/libXft-$(XFT_VER)
XT          := $(DEPSDIR)/libXt-$(XT_VER)
XPM          := $(DEPSDIR)/libXpm-$(XPM_VER)
XMU          := $(DEPSDIR)/libXmu-$(XMU_VER)
SM           := $(DEPSDIR)/libSM-$(SM_VER)
ICE           := $(DEPSDIR)/libICE-$(ICE_VER)
MOTIF        := $(DEPSDIR)/motif-$(MOTIF_VER)

define TECGRAF_BUILD_OPTIONS
	TEC_SYSNAME=$(TEC_SYSNAME) \
	TEC_UNAME=$(TEC_UNAME) \
	CC=$(TARGET_CC) \
	CPPC=$(TARGET_CXX) \
	RANLIB=$(TARGET_RANLIB) \
	AR=$(TARGET_AR) \
	LD=$(TARGET_LD) \
	LINKER=$(TARGET_LD) \
	RCC=$(TARGET_WINDRES) \
	LUA_INC=$(LUA)/src \
	USE_LUA_VERSION=$(LUA_DLLVER) \
	LIBLUA_SFX='$(LUA_SFX)' \
	LIBEXT=$(TARGET_LIBEXT) \
	USE_X11=$(USE_X11) \
	USE_GTK3=$(USE_GTK3) \
	USE_GTK=$(USE_GTK) \
	GTK_DEFAULT=$(GTK_DEFAULT) \
	NO_GTK_DEFAULT=$(NO_GTK_DEFAULT) \
	USE_XRENDER=$(USE_XRENDER) \
	USE_MOTIF=$(USE_MOTIF) \
	USE_GDK=$(USE_GDK) \
	NO_DYNAMIC=Yes \
	NO_STATIC=No \
	X11_INC=$(X11)/iup_$(TARGET)/include \
	X11_LIB=$(X11)/iup_$(TARGET)/lib \
	FREETYPE_INC=$(FREETYPE)/include \
	FREETYPE_LIB=$(FREETYPE)/lib/$(TEC_UNAME) \
	ZLIB_INC=$(ZLIB)/include \
	ZLIB_LIB=$(ZLIB)/lib/$(TEC_UNAME) \
	FTGL_INC=$(FTGL)/include \
	FTGL_LIB=$(FTGL)/lib/$(TEC_UNAME) \
	LUA_LIB=$(LUA)/lib/$(TEC_UNAME)
endef

all:

$(DEPSDIR)/.exists:
	mkdir -p "$(DEPSDIR)"
	touch "$(DEPSDIR)/.exists"

$(X11)/.exists:
	mkdir -p "$(X11)"
	touch "$(X11)/.exists"

$(X11): $(X11)/.exists

$(LIBX11_TARBALL).done: $(DEPSDIR)/.exists $(LIBX11_TARBALL).sha256sum
	curl -R -L -o "$(LIBX11_TARBALL)" "$(LIBX11_SITE)/libX11-$(LIBX11_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(LIBX11_TARBALL).sha256sum
	touch $(LIBX11_TARBALL).done

$(LIBXCB_TARBALL).done: $(DEPSDIR)/.exists $(LIBXCB_TARBALL).sha256sum
	curl -R -L -o "$(LIBXCB_TARBALL)" "$(LIBXCB_SITE)/libxcb-$(LIBXCB_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(LIBXCB_TARBALL).sha256sum
	touch $(LIBXCB_TARBALL).done

$(LIBXAU_TARBALL).done: $(DEPSDIR)/.exists $(LIBXAU_TARBALL).sha256sum
	curl -R -L -o "$(LIBXAU_TARBALL)" "$(LIBXAU_SITE)/libXau-$(LIBXAU_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(LIBXAU_TARBALL).sha256sum
	touch $(LIBXAU_TARBALL).done

$(LIBXEXT_TARBALL).done: $(DEPSDIR)/.exists $(LIBXEXT_TARBALL).sha256sum
	curl -R -L -o "$(LIBXEXT_TARBALL)" "$(LIBXEXT_SITE)/libXext-$(LIBXEXT_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(LIBXEXT_TARBALL).sha256sum
	touch $(LIBXEXT_TARBALL).done

$(XTRANS_TARBALL).done: $(DEPSDIR)/.exists $(XTRANS_TARBALL).sha256sum
	curl -R -L -o "$(XTRANS_TARBALL)" "$(XTRANS_SITE)/xtrans-$(XTRANS_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XTRANS_TARBALL).sha256sum
	touch $(XTRANS_TARBALL).done

$(XPROTO_TARBALL).done: $(DEPSDIR)/.exists $(XPROTO_TARBALL).sha256sum
	curl -R -L -o "$(XPROTO_TARBALL)" "$(XPROTO_SITE)/xproto-$(XPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XPROTO_TARBALL).sha256sum
	touch $(XPROTO_TARBALL).done

$(XEXTPROTO_TARBALL).done: $(DEPSDIR)/.exists $(XEXTPROTO_TARBALL).sha256sum
	curl -R -L -o "$(XEXTPROTO_TARBALL)" "$(XEXTPROTO_SITE)/xextproto-$(XEXTPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XEXTPROTO_TARBALL).sha256sum
	touch $(XEXTPROTO_TARBALL).done

$(GLPROTO_TARBALL).done: $(DEPSDIR)/.exists $(GLPROTO_TARBALL).sha256sum
	curl -R -L -o "$(GLPROTO_TARBALL)" "$(GLPROTO_SITE)/glproto-$(GLPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(GLPROTO_TARBALL).sha256sum
	touch $(GLPROTO_TARBALL).done

$(DRI2PROTO_TARBALL).done: $(DEPSDIR)/.exists $(DRI2PROTO_TARBALL).sha256sum
	curl -R -L -o "$(DRI2PROTO_TARBALL)" "$(DRI2PROTO_SITE)/dri2proto-$(DRI2PROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(DRI2PROTO_TARBALL).sha256sum
	touch $(DRI2PROTO_TARBALL).done

$(KBPROTO_TARBALL).done: $(DEPSDIR)/.exists $(KBPROTO_TARBALL).sha256sum
	curl -R -L -o "$(KBPROTO_TARBALL)" "$(KBPROTO_SITE)/kbproto-$(KBPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(KBPROTO_TARBALL).sha256sum
	touch $(KBPROTO_TARBALL).done

$(INPUTPROTO_TARBALL).done: $(DEPSDIR)/.exists $(INPUTPROTO_TARBALL).sha256sum
	curl -R -L -o "$(INPUTPROTO_TARBALL)" "$(INPUTPROTO_SITE)/inputproto-$(INPUTPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(INPUTPROTO_TARBALL).sha256sum
	touch $(INPUTPROTO_TARBALL).done

$(RENDERPROTO_TARBALL).done: $(DEPSDIR)/.exists $(RENDERPROTO_TARBALL).sha256sum
	curl -R -L -o "$(RENDERPROTO_TARBALL)" "$(RENDERPROTO_SITE)/renderproto-$(RENDERPROTO_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(RENDERPROTO_TARBALL).sha256sum
	touch $(RENDERPROTO_TARBALL).done

$(MESA_TARBALL).done: $(DEPSDIR)/.exists $(MESA_TARBALL).sha256sum
	curl -R -L -o "$(MESA_TARBALL)" "$(MESA_SITE)mesa-$(MESA_VER).tar.xz"
	cd $(DEPSDIR) && sha256sum -c $(MESA_TARBALL).sha256sum
	touch $(MESA_TARBALL).done

$(GLU_TARBALL).done: $(DEPSDIR)/.exists $(GLU_TARBALL).sha256sum
	curl -R -L -o "$(GLU_TARBALL)" "$(GLU_SITE)glu-$(GLU_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(GLU_TARBALL).sha256sum
	touch $(GLU_TARBALL).done

$(LIBDRM_TARBALL).done: $(DEPSDIR)/.exists $(LIBDRM_TARBALL).sha256sum
	curl -R -L -o "$(LIBDRM_TARBALL)" "$(LIBDRM_SITE)libdrm-$(LIBDRM_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(LIBDRM_TARBALL).sha256sum
	touch $(LIBDRM_TARBALL).done

$(MOTIF_TARBALL).done: $(DEPSDIR)/.exists $(MOTIF_TARBALL).sha256sum
	curl -R -L -o "$(MOTIF_TARBALL)" "$(MOTIF_SITE)motif-$(MOTIF_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(MOTIF_TARBALL).sha256sum
	touch $(MOTIF_TARBALL).done

$(ZLIB_TARBALL).done: $(DEPSDIR)/.exists $(ZLIB_TARBALL).sha256sum
	curl -R -L -o "$(ZLIB_TARBALL)" "$(ZLIB_SITE)/zlib-$(ZLIB_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(ZLIB_TARBALL).sha256sum
	touch $(ZLIB_TARBALL).done

$(EXPAT_TARBALL).done: $(DEPSDIR)/.exists $(EXPAT_TARBALL).sha256sum
	curl -R -L -o "$(EXPAT_TARBALL)" "$(EXPAT_SITE)expat-$(EXPAT_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(EXPAT_TARBALL).sha256sum
	touch $(EXPAT_TARBALL).done

$(FONTCONFIG_TARBALL).done: $(DEPSDIR)/.exists $(FONTCONFIG_TARBALL).sha256sum
	curl -R -L -o "$(FONTCONFIG_TARBALL)" "$(FONTCONFIG_SITE)fontconfig-$(FONTCONFIG_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(FONTCONFIG_TARBALL).sha256sum
	touch $(FONTCONFIG_TARBALL).done

$(XRENDER_TARBALL).done: $(DEPSDIR)/.exists $(XRENDER_TARBALL).sha256sum
	curl -R -L -o "$(XRENDER_TARBALL)" "$(XRENDER_SITE)/libXrender-$(XRENDER_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XRENDER_TARBALL).sha256sum
	touch $(XRENDER_TARBALL).done

$(XFT_TARBALL).done: $(DEPSDIR)/.exists $(XFT_TARBALL).sha256sum
	curl -R -L -o "$(XFT_TARBALL)" "$(XFT_SITE)/libXft-$(XFT_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XFT_TARBALL).sha256sum
	touch $(XFT_TARBALL).done

$(SM_TARBALL).done: $(DEPSDIR)/.exists $(SM_TARBALL).sha256sum
	curl -R -L -o "$(SM_TARBALL)" "$(SM_SITE)/libSM-$(SM_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(SM_TARBALL).sha256sum
	touch $(SM_TARBALL).done

$(ICE_TARBALL).done: $(DEPSDIR)/.exists $(ICE_TARBALL).sha256sum
	curl -R -L -o "$(ICE_TARBALL)" "$(ICE_SITE)/libICE-$(ICE_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(ICE_TARBALL).sha256sum
	touch $(ICE_TARBALL).done

$(XT_TARBALL).done: $(DEPSDIR)/.exists $(XT_TARBALL).sha256sum
	curl -R -L -o "$(XT_TARBALL)" "$(XT_SITE)/libXt-$(XT_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XT_TARBALL).sha256sum
	touch $(XT_TARBALL).done

$(XPM_TARBALL).done: $(DEPSDIR)/.exists $(XPM_TARBALL).sha256sum
	curl -R -L -o "$(XPM_TARBALL)" "$(XPM_SITE)/libXpm-$(XPM_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XPM_TARBALL).sha256sum
	touch $(XPM_TARBALL).done

$(XMU_TARBALL).done: $(DEPSDIR)/.exists $(XMU_TARBALL).sha256sum
	curl -R -L -o "$(XMU_TARBALL)" "$(XMU_SITE)/libXmu-$(XMU_VER).tar.bz2"
	cd $(DEPSDIR) && sha256sum -c $(XMU_TARBALL).sha256sum
	touch $(XMU_TARBALL).done

$(FTGL_TARBALL).done: $(DEPSDIR)/.exists $(FTGL_TARBALL).sha256sum
	curl -R -L -o "$(FTGL_TARBALL)" "$(FTGL_SITE)/ftgl-$(FTGL_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(FTGL_TARBALL).sha256sum
	touch $(FTGL_TARBALL).done

$(FREETYPE_TARBALL).done: $(DEPSDIR)/.exists $(FREETYPE_TARBALL).sha256sum
	curl -R -L -o "$(FREETYPE_TARBALL)" "$(FREETYPE_SITE)/freetype-$(FREETYPE_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(FREETYPE_TARBALL).sha256sum
	touch $(FREETYPE_TARBALL).done

$(CD_TARBALL).done: $(DEPSDIR)/.exists $(CD_TARBALL).sha256sum
	curl -R -L -o "$(CD_TARBALL)" "$(CD_SITE)/cd-$(CD_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(CD_TARBALL).sha256sum
	touch $(CD_TARBALL).done

$(IM_TARBALL).done: $(DEPSDIR)/.exists $(IM_TARBALL).sha256sum
	curl -R -L -o "$(IM_TARBALL)" "$(IM_SITE)/im-$(IM_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(IM_TARBALL).sha256sum
	touch $(IM_TARBALL).done

$(IUP_TARBALL).done: $(DEPSDIR)/.exists $(IUP_TARBALL).sha256sum
	curl -R -L -o "$(IUP_TARBALL)" "$(IUP_SITE)/iup-$(IUP_VER)_Sources.tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(IUP_TARBALL).sha256sum
	touch $(IUP_TARBALL).done

$(LUA_TARBALL).done: $(DEPSDIR)/.exists $(LUA_TARBALL).sha256sum
	curl -R -L -o "$(LUA_TARBALL)" "$(LUA_SITE)/lua-$(LUA_VER).tar.gz"
	cd $(DEPSDIR) && sha256sum -c $(LUA_TARBALL).sha256sum
	touch $(LUA_TARBALL).done

$(LIBX11)/.extracted: $(LIBX11_TARBALL).done
	rm -rf "$(LIBX11)"
	mkdir -p "$(LIBX11).tmp"
	tar -xvf "$(LIBX11_TARBALL)" --strip 1 -C "$(LIBX11).tmp"
	mv "$(LIBX11).tmp" "$(LIBX11)"
	if [ -e $(PATCHDIR)/libX11-$(LIBX11_VER) ] ; then \
		cd "$(LIBX11)" && \
		for p in $(PATCHDIR)/libX11-$(LIBX11_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LIBX11)/.extracted"

$(LIBX11): $(LIBX11)/.extracted

$(LIBXCB)/.extracted: $(LIBXCB_TARBALL).done
	rm -rf "$(LIBXCB)"
	mkdir -p "$(LIBXCB).tmp"
	tar -xvf "$(LIBXCB_TARBALL)" --strip 1 -C "$(LIBXCB).tmp"
	mv "$(LIBXCB).tmp" "$(LIBXCB)"
	if [ -e $(PATCHDIR)/libxcb-$(LIBXCB_VER) ] ; then \
		cd "$(LIBXCB)" && \
		for p in $(PATCHDIR)/libxcb-$(LIBXCB_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LIBXCB)/.extracted"

$(LIBXCB): $(LIBXCB)/.extracted

$(LIBXAU)/.extracted: $(LIBXAU_TARBALL).done
	rm -rf "$(LIBXAU)"
	mkdir -p "$(LIBXAU).tmp"
	tar -xvf "$(LIBXAU_TARBALL)" --strip 1 -C "$(LIBXAU).tmp"
	mv "$(LIBXAU).tmp" "$(LIBXAU)"
	if [ -e $(PATCHDIR)/libXau-$(LIBXAU_VER) ] ; then \
		cd "$(LIBXAU)" && \
		for p in $(PATCHDIR)/libXau-$(LIBXAU_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LIBXAU)/.extracted"

$(LIBXAU): $(LIBXAU)/.extracted

$(LIBXEXT)/.extracted: $(LIBXEXT_TARBALL).done
	rm -rf "$(LIBXEXT)"
	mkdir -p "$(LIBXEXT).tmp"
	tar -xvf "$(LIBXEXT_TARBALL)" --strip 1 -C "$(LIBXEXT).tmp"
	mv "$(LIBXEXT).tmp" "$(LIBXEXT)"
	if [ -e $(PATCHDIR)/libXext-$(LIBXEXT_VER) ] ; then \
		cd "$(LIBXEXT)" && \
		for p in $(PATCHDIR)/libXext-$(LIBXEXT_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LIBXEXT)/.extracted"

$(LIBXEXT): $(LIBXEXT)/.extracted

$(XTRANS)/.extracted: $(XTRANS_TARBALL).done
	rm -rf "$(XTRANS)"
	mkdir -p "$(XTRANS).tmp"
	tar -xvf "$(XTRANS_TARBALL)" --strip 1 -C "$(XTRANS).tmp"
	mv "$(XTRANS).tmp" "$(XTRANS)"
	if [ -e $(PATCHDIR)/xtrans-$(XTRANS_VER) ] ; then \
		cd "$(XTRANS)" && \
		for p in $(PATCHDIR)/xtrans-$(XTRANS_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XTRANS)/.extracted"

$(XTRANS): $(XTRANS)/.extracted

$(XPROTO)/.extracted: $(XPROTO_TARBALL).done
	rm -rf "$(XPROTO)"
	mkdir -p "$(XPROTO).tmp"
	tar -xvf "$(XPROTO_TARBALL)" --strip 1 -C "$(XPROTO).tmp"
	mv "$(XPROTO).tmp" "$(XPROTO)"
	if [ -e $(PATCHDIR)/xproto-$(XPROTO_VER) ] ; then \
		cd "$(XPROTO)" && \
		for p in $(PATCHDIR)/xproto-$(XPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XPROTO)/.extracted"

$(XPROTO): $(XPROTO)/.extracted

$(XEXTPROTO)/.extracted: $(XEXTPROTO_TARBALL).done
	rm -rf "$(XEXTPROTO)"
	mkdir -p "$(XEXTPROTO).tmp"
	tar -xvf "$(XEXTPROTO_TARBALL)" --strip 1 -C "$(XEXTPROTO).tmp"
	mv "$(XEXTPROTO).tmp" "$(XEXTPROTO)"
	if [ -e $(PATCHDIR)/xextproto-$(XEXTPROTO_VER) ] ; then \
		cd "$(XEXTPROTO)" && \
		for p in $(PATCHDIR)/xextproto-$(XEXTPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XEXTPROTO)/.extracted"

$(XEXTPROTO): $(XEXTPROTO)/.extracted

$(GLPROTO)/.extracted: $(GLPROTO_TARBALL).done
	rm -rf "$(GLPROTO)"
	mkdir -p "$(GLPROTO).tmp"
	tar -xvf "$(GLPROTO_TARBALL)" --strip 1 -C "$(GLPROTO).tmp"
	mv "$(GLPROTO).tmp" "$(GLPROTO)"
	if [ -e $(PATCHDIR)/glproto-$(GLPROTO_VER) ] ; then \
		cd "$(GLPROTO)" && \
		for p in $(PATCHDIR)/glproto-$(GLPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(GLPROTO)/.extracted"

$(GLPROTO): $(GLPROTO)/.extracted

$(DRI2PROTO)/.extracted: $(DRI2PROTO_TARBALL).done
	rm -rf "$(DRI2PROTO)"
	mkdir -p "$(DRI2PROTO).tmp"
	tar -xvf "$(DRI2PROTO_TARBALL)" --strip 1 -C "$(DRI2PROTO).tmp"
	mv "$(DRI2PROTO).tmp" "$(DRI2PROTO)"
	if [ -e $(PATCHDIR)/dri2proto-$(DRI2PROTO_VER) ] ; then \
		cd "$(DRI2PROTO)" && \
		for p in $(PATCHDIR)/dri2proto-$(DRI2PROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(DRI2PROTO)/.extracted"

$(DRI2PROTO): $(DRI2PROTO)/.extracted

$(MOTIF)/.extracted: $(MOTIF_TARBALL).done
	rm -rf "$(MOTIF)"
	mkdir -p "$(MOTIF).tmp"
	tar -xvf "$(MOTIF_TARBALL)" --strip 1 -C "$(MOTIF).tmp"
	mv "$(MOTIF).tmp" "$(MOTIF)"
	if [ -e $(PATCHDIR)/motif-$(MOTIF_VER) ] ; then \
		cd "$(MOTIF)" && \
		for p in $(PATCHDIR)/motif-$(MOTIF_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(MOTIF)/.extracted"

$(MOTIF): $(MOTIF)/.extracted

$(KBPROTO)/.extracted: $(KBPROTO_TARBALL).done
	rm -rf "$(KBPROTO)"
	mkdir -p "$(KBPROTO).tmp"
	tar -xvf "$(KBPROTO_TARBALL)" --strip 1 -C "$(KBPROTO).tmp"
	mv "$(KBPROTO).tmp" "$(KBPROTO)"
	if [ -e $(PATCHDIR)/kbproto-$(KBPROTO_VER) ] ; then \
		cd "$(KBPROTO)" && \
		for p in $(PATCHDIR)/kbproto-$(KBPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(KBPROTO)/.extracted"

$(KBPROTO): $(KBPROTO)/.extracted

$(INPUTPROTO)/.extracted: $(INPUTPROTO_TARBALL).done
	rm -rf "$(INPUTPROTO)"
	mkdir -p "$(INPUTPROTO).tmp"
	tar -xvf "$(INPUTPROTO_TARBALL)" --strip 1 -C "$(INPUTPROTO).tmp"
	mv "$(INPUTPROTO).tmp" "$(INPUTPROTO)"
	if [ -e $(PATCHDIR)/inputproto-$(INPUTPROTO_VER) ] ; then \
		cd "$(INPUTPROTO)" && \
		for p in $(PATCHDIR)/inputproto-$(INPUTPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(INPUTPROTO)/.extracted"

$(INPUTPROTO): $(INPUTPROTO)/.extracted

$(RENDERPROTO)/.extracted: $(RENDERPROTO_TARBALL).done
	rm -rf "$(RENDERPROTO)"
	mkdir -p "$(RENDERPROTO).tmp"
	tar -xvf "$(RENDERPROTO_TARBALL)" --strip 1 -C "$(RENDERPROTO).tmp"
	mv "$(RENDERPROTO).tmp" "$(RENDERPROTO)"
	if [ -e $(PATCHDIR)/renderproto-$(RENDERPROTO_VER) ] ; then \
		cd "$(RENDERPROTO)" && \
		for p in $(PATCHDIR)/renderproto-$(RENDERPROTO_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(RENDERPROTO)/.extracted"

$(RENDERPROTO): $(RENDERPROTO)/.extracted

$(MESA)/.extracted: $(MESA_TARBALL).done
	rm -rf "$(MESA)"
	mkdir -p "$(MESA).tmp"
	tar -xvf "$(MESA_TARBALL)" --strip 1 -C "$(MESA).tmp"
	mv "$(MESA).tmp" "$(MESA)"
	if [ -e $(PATCHDIR)/mesa-$(MESA_VER) ] ; then \
		cd "$(MESA)" && \
		for p in $(PATCHDIR)/mesa-$(MESA_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(MESA)/.extracted"

$(MESA): $(MESA)/.extracted

$(GLU)/.extracted: $(GLU_TARBALL).done
	rm -rf "$(GLU)"
	mkdir -p "$(GLU).tmp"
	tar -xvf "$(GLU_TARBALL)" --strip 1 -C "$(GLU).tmp"
	mv "$(GLU).tmp" "$(GLU)"
	if [ -e $(PATCHDIR)/glu-$(GLU_VER) ] ; then \
		cd "$(GLU)" && \
		for p in $(PATCHDIR)/glu-$(GLU_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(GLU)/.extracted"

$(GLU): $(GLU)/.extracted

$(LIBDRM)/.extracted: $(LIBDRM_TARBALL).done
	rm -rf "$(LIBDRM)"
	mkdir -p "$(LIBDRM).tmp"
	tar -xvf "$(LIBDRM_TARBALL)" --strip 1 -C "$(LIBDRM).tmp"
	mv "$(LIBDRM).tmp" "$(LIBDRM)"
	if [ -e $(PATCHDIR)/libdrm-$(LIBDRM_VER) ] ; then \
		cd "$(LIBDRM)" && \
		for p in $(PATCHDIR)/libdrm-$(LIBDRM_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LIBDRM)/.extracted"

$(LIBDRM): $(LIBDRM)/.extracted

$(ZLIB)/.extracted: $(ZLIB_TARBALL).done
	rm -rf "$(ZLIB)"
	mkdir -p "$(ZLIB).tmp"
	tar -xvf "$(ZLIB_TARBALL)" --strip 1 -C "$(ZLIB).tmp"
	mv "$(ZLIB).tmp" "$(ZLIB)"
	if [ -e $(PATCHDIR)/zlib-$(ZLIB_VER) ] ; then \
		cd "$(ZLIB)" && \
		for p in $(PATCHDIR)/zlib-$(ZLIB_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(ZLIB)/.extracted"

$(ZLIB): $(ZLIB)/.extracted

$(EXPAT)/.extracted: $(EXPAT_TARBALL).done
	rm -rf "$(EXPAT)"
	mkdir -p "$(EXPAT).tmp"
	tar -xvf "$(EXPAT_TARBALL)" --strip 1 -C "$(EXPAT).tmp"
	mv "$(EXPAT).tmp" "$(EXPAT)"
	if [ -e $(PATCHDIR)/expat-$(EXPAT_VER) ] ; then \
		cd "$(EXPAT)" && \
		for p in $(PATCHDIR)/expat-$(EXPAT_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(EXPAT)/.extracted"

$(EXPAT): $(EXPAT)/.extracted

$(FONTCONFIG)/.extracted: $(FONTCONFIG_TARBALL).done
	rm -rf "$(FONTCONFIG)"
	mkdir -p "$(FONTCONFIG).tmp"
	tar -xvf "$(FONTCONFIG_TARBALL)" --strip 1 -C "$(FONTCONFIG).tmp"
	mv "$(FONTCONFIG).tmp" "$(FONTCONFIG)"
	if [ -e $(PATCHDIR)/fontconfig-$(FONTCONFIG_VER) ] ; then \
		cd "$(FONTCONFIG)" && \
		for p in $(PATCHDIR)/fontconfig-$(FONTCONFIG_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(FONTCONFIG)/.extracted"

$(FONTCONFIG): $(FONTCONFIG)/.extracted

$(XRENDER)/.extracted: $(XRENDER_TARBALL).done
	rm -rf "$(XRENDER)"
	mkdir -p "$(XRENDER).tmp"
	tar -xvf "$(XRENDER_TARBALL)" --strip 1 -C "$(XRENDER).tmp"
	mv "$(XRENDER).tmp" "$(XRENDER)"
	if [ -e $(PATCHDIR)/libXrender-$(XRENDER_VER) ] ; then \
		cd "$(XRENDER)" && \
		for p in $(PATCHDIR)/libXrender-$(XRENDER_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XRENDER)/.extracted"

$(XRENDER): $(XRENDER)/.extracted

$(XFT)/.extracted: $(XFT_TARBALL).done
	rm -rf "$(XFT)"
	mkdir -p "$(XFT).tmp"
	tar -xvf "$(XFT_TARBALL)" --strip 1 -C "$(XFT).tmp"
	mv "$(XFT).tmp" "$(XFT)"
	if [ -e $(PATCHDIR)/libXft-$(XFT_VER) ] ; then \
		cd "$(XFT)" && \
		for p in $(PATCHDIR)/libXft-$(XFT_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XFT)/.extracted"

$(XFT): $(XFT)/.extracted

$(SM)/.extracted: $(SM_TARBALL).done
	rm -rf "$(SM)"
	mkdir -p "$(SM).tmp"
	tar -xvf "$(SM_TARBALL)" --strip 1 -C "$(SM).tmp"
	mv "$(SM).tmp" "$(SM)"
	if [ -e $(PATCHDIR)/libSM-$(SM_VER) ] ; then \
		cd "$(SM)" && \
		for p in $(PATCHDIR)/libSM-$(SM_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(SM)/.extracted"

$(SM): $(SM)/.extracted

$(ICE)/.extracted: $(ICE_TARBALL).done
	rm -rf "$(ICE)"
	mkdir -p "$(ICE).tmp"
	tar -xvf "$(ICE_TARBALL)" --strip 1 -C "$(ICE).tmp"
	mv "$(ICE).tmp" "$(ICE)"
	if [ -e $(PATCHDIR)/libICE-$(ICE_VER) ] ; then \
		cd "$(ICE)" && \
		for p in $(PATCHDIR)/libICE-$(ICE_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(ICE)/.extracted"

$(ICE): $(ICE)/.extracted

$(XT)/.extracted: $(XT_TARBALL).done
	rm -rf "$(XT)"
	mkdir -p "$(XT).tmp"
	tar -xvf "$(XT_TARBALL)" --strip 1 -C "$(XT).tmp"
	mv "$(XT).tmp" "$(XT)"
	if [ -e $(PATCHDIR)/libXt-$(XT_VER) ] ; then \
		cd "$(XT)" && \
		for p in $(PATCHDIR)/libXt-$(XT_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XT)/.extracted"

$(XT): $(XT)/.extracted

$(XPM)/.extracted: $(XPM_TARBALL).done
	rm -rf "$(XPM)"
	mkdir -p "$(XPM).tmp"
	tar -xvf "$(XPM_TARBALL)" --strip 1 -C "$(XPM).tmp"
	mv "$(XPM).tmp" "$(XPM)"
	if [ -e $(PATCHDIR)/libXpm-$(XPM_VER) ] ; then \
		cd "$(XPM)" && \
		for p in $(PATCHDIR)/libXpm-$(XPM_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XPM)/.extracted"

$(XPM): $(XPM)/.extracted

$(XMU)/.extracted: $(XMU_TARBALL).done
	rm -rf "$(XMU)"
	mkdir -p "$(XMU).tmp"
	tar -xvf "$(XMU_TARBALL)" --strip 1 -C "$(XMU).tmp"
	mv "$(XMU).tmp" "$(XMU)"
	if [ -e $(PATCHDIR)/libXmu-$(XMU_VER) ] ; then \
		cd "$(XMU)" && \
		for p in $(PATCHDIR)/libXmu-$(XMU_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(XMU)/.extracted"

$(XMU): $(XMU)/.extracted

$(FTGL)/.extracted: $(FTGL_TARBALL).done
	rm -rf "$(FTGL)"
	mkdir -p "$(FTGL).tmp"
	tar -xvf "$(FTGL_TARBALL)" --strip 1 -C "$(FTGL).tmp"
	mv "$(FTGL).tmp" "$(FTGL)"
	if [ -e $(PATCHDIR)/ftgl-$(FTGL_VER) ] ; then \
		cd $(FTGL) && \
		for p in $(PATCHDIR)/ftgl-$(FTGL_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(FTGL)/.extracted"

$(FTGL): $(FTGL)/.extracted

$(FREETYPE)/.extracted: $(FREETYPE_TARBALL).done
	rm -rf "$(FREETYPE)"
	mkdir -p "$(FREETYPE).tmp"
	tar -xvf "$(FREETYPE_TARBALL)" --strip 1 -C "$(FREETYPE).tmp"
	mv "$(FREETYPE).tmp" "$(FREETYPE)"
	if [ -e $(PATCHDIR)/freetype-$(FREETYPE_VER) ] ; then \
		cd $(FREETYPE) && \
		for p in $(PATCHDIR)/freetype-$(FREETYPE_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(FREETYPE)/.extracted"

$(FREETYPE): $(FREETYPE)/.extracted

$(CD)/.extracted: $(CD_TARBALL).done
	rm -rf "$(CD)"
	mkdir -p "$(CD).tmp"
	tar -xvf "$(CD_TARBALL)" --strip 1 -C "$(CD).tmp"
	mv "$(CD).tmp" "$(CD)"
	if [ -e $(PATCHDIR)/cd-$(CD_VER) ] ; then \
		cd $(CD) && \
		for p in $(PATCHDIR)/cd-$(CD_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(CD)/.extracted"

$(CD): $(CD)/.extracted

$(IM)/.extracted: $(IM_TARBALL).done
	rm -rf "$(IM)"
	mkdir -p "$(IM).tmp"
	tar -xvf "$(IM_TARBALL)" --strip 1 -C "$(IM).tmp"
	mv "$(IM).tmp" "$(IM)"
	if [ -e $(PATCHDIR)/im-$(IM_VER) ] ; then \
		cd $(IM) && \
		for p in $(PATCHDIR)/im-$(IM_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(IM)/.extracted"

$(IM): $(IM)/.extracted

$(IUP)/.extracted: $(IUP_TARBALL).done
	rm -rf "$(IUP)"
	mkdir -p "$(IUP).tmp"
	tar -xvf "$(IUP_TARBALL)" --strip 1 -C "$(IUP).tmp"
	mv "$(IUP).tmp" "$(IUP)"
	if [ -e $(PATCHDIR)/iup-$(IUP_VER) ] ; then \
		cd $(IUP) && \
		for p in $(PATCHDIR)/iup-$(IUP_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(IUP)/.extracted"


$(IUP): $(IUP)/.extracted

$(LUA)/.extracted: $(LUA_TARBALL).done
	rm -rf "$(LUA)"
	mkdir -p "$(LUA).tmp"
	tar -xvf "$(LUA_TARBALL)" --strip 1 -C "$(LUA).tmp"
	mv "$(LUA).tmp" "$(LUA)"
	if [ -e $(PATCHDIR)/cd-$(LUA_VER) ] ; then \
		cd $(LUA) && \
		for p in $(PATCHDIR)/lua-$(LUA_VER)/* ; do \
			patch -p1 < "$${p}" ; \
		done ; \
	fi
	touch "$(LUA)/.extracted"

$(LUA): $(LUA)/.extracted

LIBZLIB        := $(ZLIB)/lib/$(TEC_UNAME)/libz.a
LIBFREETYPE    := $(FREETYPE)/lib/$(TEC_UNAME)/libfreetype.a
LIBFTGL        := $(FTGL)/lib/$(TEC_UNAME)/libftgl.a
LIBLUA         := $(LUA)/lib/$(TEC_UNAME)/liblua.a
LIBX11_LIB     := $(X11)/iup_$(TARGET)/lib/libX11.a
LIBXCB_LIB     := $(X11)/iup_$(TARGET)/lib/libxcb.a
LIBXAU_LIB     := $(X11)/iup_$(TARGET)/lib/libXau.a
LIBXEXT_LIB    := $(X11)/iup_$(TARGET)/lib/libXext.a
LIBXPROTO      := $(X11)/iup_$(TARGET)/include/X11/keysymdef.h
LIBXEXTPROTO   := $(X11)/iup_$(TARGET)/include/X11/extensions/lbx.h
LIBGLPROTO     := $(X11)/iup_$(TARGET)/include/GL/glxproto.h
LIBDRI2PROTO   := $(X11)/iup_$(TARGET)/include/X11/extensions/dri2proto.h
LIBKBPROTO     := $(X11)/iup_$(TARGET)/include/X11/extensions/XKB.h
LIBINPUTPROTO  := $(X11)/iup_$(TARGET)/include/X11/extensions/XI.h
LIBRENDERPROTO  := $(X11)/iup_$(TARGET)/include/X11/extensions/render.h
LIBXTRANS      := $(X11)/iup_$(TARGET)/include/X11/Xtrans/Xtrans.h
LIBMESA        := $(X11)/iup_$(TARGET)/include/GL/gl.h
LIBGLU         := $(X11)/iup_$(TARGET)/include/GL/glu.h
LIBDRM_LIB     := $(X11)/iup_$(TARGET)/lib/libdrm.a
LIBEXPAT       := $(X11)/iup_$(TARGET)/lib/libexpat.a
LIBFONTCONFIG  := $(X11)/iup_$(TARGET)/lib/libfontconfig.a
LIBXRENDER     := $(X11)/iup_$(TARGET)/lib/libXrender.a
LIBXFT         := $(X11)/iup_$(TARGET)/lib/libXft.a
LIBXT          := $(X11)/iup_$(TARGET)/lib/libXt.a
LIBXPM         := $(X11)/iup_$(TARGET)/lib/libXpm.a
LIBXMU         := $(X11)/iup_$(TARGET)/lib/libXmu.a
LIBICE         := $(X11)/iup_$(TARGET)/lib/libICE.a
LIBSM         := $(X11)/iup_$(TARGET)/lib/libSM.a
LIBMOTIF       := $(X11)/iup_$(TARGET)/lib/libXm.a

LIBLUA_LIBDIR     = $(LUA)/lib/$(TEC_UNAME)

LIBIM             := $(IM)/lib/$(TEC_UNAME)/libim.a
LIBIM_JP2         := $(IM)/lib/$(TEC_UNAME)/libim_jp2.a
LIBIM_PROCESS     := $(IM)/lib/$(TEC_UNAME)/libim_process.a
LIBIM_FFTW        := $(IM)/lib/$(TEC_UNAME)/libim_fftw.a
LIBIM_LZO         := $(IM)/lib/$(TEC_UNAME)/libim_lzo.a
LIBIM_PROCESS_OMP := $(IM)/lib/$(TEC_UNAME)/libim_process_omp.a
LIBIMLUA          := $(IM)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libimlua$(LUA_DLLVER).a
LIBIMLUA_JP2      := $(IM)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libimlua_jp2$(LUA_DLLVER).a
LIBIMLUA_PROCESS  := $(IM)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libimlua_process$(LUA_DLLVER).a
LIBIMLUA_FFTW     := $(IM)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libimlua_fftw$(LUA_DLLVER).a

LIBIM_LIBDIR    = $(IM)/lib/$(TEC_UNAME)
LIBIM_LUALIBDIR = $(IM)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)

LIBCD                := $(CD)/lib/$(TEC_UNAME)/libcd.a
LIBCD_PDFLIB         := $(CD)/lib/$(TEC_UNAME)/libcd_pdflib.a
LIBCDPDF             := $(CD)/lib/$(TEC_UNAME)/libcdpdf.a
LIBCDGL              := $(CD)/lib/$(TEC_UNAME)/libcdgl.a
LIBCDIM              := $(CD)/lib/$(TEC_UNAME)/libcdim.a
LIBCDCONTEXTPLUS     := $(CD)/lib/$(TEC_UNAME)/libcdcontextplus.a
LIBCDLUA             := $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libcdlua$(LUA_DLLVER).a
LIBCDLUAPDF          := $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libcdluapdf$(LUA_DLLVER).a
LIBCDLUAGL           := $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libcdluagl$(LUA_DLLVER).a
LIBCDLUACONTEXTPLUS  := $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libcdluacontextplus$(LUA_DLLVER).a
LIBCDLUAIM           := $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libcdluaim$(LUA_DLLVER).a

LIBCD_LIBDIR    = $(CD)/lib/$(TEC_UNAME)
LIBCD_LUALIBDIR = $(CD)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)

LIBIUP               := $(IUP)/lib/$(TEC_UNAME)/libiup.a
LIBIUPCD             := $(IUP)/lib/$(TEC_UNAME)/libiupcd.a
LIBIUPCONTROLS       := $(IUP)/lib/$(TEC_UNAME)/libiupcontrols.a
LIBIUPGL             := $(IUP)/lib/$(TEC_UNAME)/libiupgl.a
LIBIUPGLCONTROLS     := $(IUP)/lib/$(TEC_UNAME)/libiupglcontrols.a
LIBIUPMATRIXEX       := $(IUP)/lib/$(TEC_UNAME)/libiupmatrixex.a
LIBIUP_PLOT          := $(IUP)/lib/$(TEC_UNAME)/libiup_plot.a
LIBIUP_MGLPLOT       := $(IUP)/lib/$(TEC_UNAME)/libiup_mglplot.a
LIBIUP_SCINTILLA     := $(IUP)/lib/$(TEC_UNAME)/libiup_scintilla.a
LIBIUPIM             := $(IUP)/lib/$(TEC_UNAME)/libiupim.a
LIBIUPIMGLIB         := $(IUP)/lib/$(TEC_UNAME)/libiupimglib.a
LIBIUPOLE            := $(IUP)/lib/$(TEC_UNAME)/libiupole.a
LIBIUPTUIO           := $(IUP)/lib/$(TEC_UNAME)/libiuptuio.a
LIBIUPLUA            := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiuplua$(LUA_DLLVER).a
LIBIUPLUACD          := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluacd$(LUA_DLLVER).a
LIBIUPLUACONTROLS    := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluacontrols$(LUA_DLLVER).a
LIBIUPLUAMATRIXEX    := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluamatrixex$(LUA_DLLVER).a
LIBIUPLUAGL          := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluagl$(LUA_DLLVER).a
LIBIUPLUAGLCONTROLS  := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluaglcontrols$(LUA_DLLVER).a
LIBIUPLUA_PLOT       := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiuplua_plot$(LUA_DLLVER).a
LIBIUPLUA_MGLPLOT    := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiuplua_mglplot$(LUA_DLLVER).a
LIBIUPLUA_SCINTILLA  := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiuplua_scintilla$(LUA_DLLVER).a
LIBIUPLUAIM          := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluaim$(LUA_DLLVER).a
LIBIUPLUAIMGLIB      := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluaimglib$(LUA_DLLVER).a
LIBIUPLUATUIO        := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluatuio$(LUA_DLLVER).a
LIBIUPLUAOLE         := $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)/libiupluaole$(LUA_DLLVER).a

LIBIUP_LIBDIR    = $(IUP)/lib/$(TEC_UNAME)
LIBIUP_LUALIBDIR = $(IUP)/lib/$(TEC_UNAME)/Lua$(LUA_SFX)

$(LIBEXPAT): $(EXPAT)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(EXPAT)" && \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)"
	make -C "$(EXPAT)"
	make -C "$(EXPAT)" install

$(LIBFONTCONFIG): $(LIBEXPAT) $(LIBFREETYPE) $(FONTCONFIG)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(FONTCONFIG)" && \
	LDFLAGS="-L$(ZLIB)/lib/$(TEC_UNAME)" \
	FREETYPE_CFLAGS="-I$(FREETYPE)/include" \
	FREETYPE_LIBS="-L$(FREETYPE)/lib/$(TEC_UNAME) -lfreetype -lz" \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static
	make -C "$(FONTCONFIG)" V=1
	make -C "$(FONTCONFIG)" install

$(LIBXTRANS): $(XTRANS)
	mkdir -p "$(X11)/iup_$(TARGET)"
	rm -f "$(XTRANS)/xtrans.pc"
	cd "$(XTRANS)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(XTRANS)"
	make -C "$(XTRANS)" install
	mkdir -p "$(X11)/iup_$(TARGET)/lib/pkgconfig"
	cp "$(XTRANS)/xtrans.pc" "$(X11)/iup_$(TARGET)/lib/pkgconfig/xtrans.pc"

$(LIBXPROTO): $(XPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(XPROTO)"
	make -C "$(XPROTO)" install

$(LIBXEXTPROTO): $(XEXTPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XEXTPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(XEXTPROTO)"
	make -C "$(XEXTPROTO)" install

$(LIBGLPROTO): $(GLPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(GLPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(GLPROTO)"
	make -C "$(GLPROTO)" install

$(LIBDRI2PROTO): $(DRI2PROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(DRI2PROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(DRI2PROTO)"
	make -C "$(DRI2PROTO)" install

$(LIBDRM_LIB): $(LIBDRM)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(LIBDRM)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --oldincludedir=/dev/null \
	  --enable-static \
	  --disable-shared \
	  --disable-libkms \
	  --disable-intel \
	  --disable-radeon \
	  --disable-amdgpu \
	  --disable-nouveau \
	  --disable-vmwgfx \
	  --disable-freedreno \
	  --disable-vc4 \
	  --disable-cairo-tests
	make -C "$(LIBDRM)"
	make -C "$(LIBDRM)" install


$(LIBMESA): $(LIBGLPROTO) $(LIBDRI2PROTO) $(LIBX11_LIB) $(LIBXEXT_LIB) $(LIBDRM_LIB) $(LIBZLIB) $(MESA)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(MESA)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	ZLIB_CFLAGS="-I$(ZLIB)/include" \
	ZLIB_LIBS="-L$(ZLIB)/lib/$(TEC_UNAME) -lz" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --oldincludedir=/dev/null \
	  --with-platforms=x11 \
	  --without-vulkan-drivers \
	  --without-dri-drivers \
	  --without-gallium-drivers \
	  --enable-static \
	  --disable-shared \
	  --disable-llvm \
	  --disable-gles1 \
	  --disable-gles2 \
	  --disable-dri \
	  --disable-egl \
	  --disable-gbm \
	  --enable-glx=xlib \
	  --enable-glx-tls
	make -C "$(MESA)"
	make -C "$(MESA)" install

$(LIBGLU): $(LIBMESA) $(GLU)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(GLU)" && \
	autoreconf -vfi && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	GL_LIBS="-L$(X11)/iup_$(TARGET)/lib -lGL -lglapi" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --oldincludedir=/dev/null \
	  --enable-static \
	  --disable-shared
	make -C "$(GLU)" LIBTOOL=slibtool
	make -C "$(GLU)" LIBTOOL=slibtool install

$(LIBKBPROTO): $(KBPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(KBPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(KBPROTO)"
	make -C "$(KBPROTO)" install

$(LIBINPUTPROTO): $(INPUTPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(INPUTPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(INPUTPROTO)"
	make -C "$(INPUTPROTO)" install

$(LIBRENDERPROTO): $(RENDERPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(RENDERPROTO)" && ./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET)
	make -C "$(RENDERPROTO)"
	make -C "$(RENDERPROTO)" install

$(LIBXAU_LIB): $(LIBXAU) $(LIBXPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(LIBXAU)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --enable-static \
	  --disable-shared
	make -C "$(LIBXAU)"
	make -C "$(LIBXAU)" install

$(LIBXEXT_LIB): $(LIBXEXT) $(LIBX11_LIB) $(LIBXEXTPROTO)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(LIBXEXT)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --enable-ipv6 \
	  --enable-static \
	  --disable-shared \
	  --enable-malloc0returnsnull
	make -C "$(LIBXEXT)"
	make -C "$(LIBXEXT)" install

$(LIBXCB_LIB): $(LIBXCB) $(LIBXAU_LIB)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(LIBXCB)" && \
	autoreconf -vfi && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --enable-static \
	  --disable-shared
	make -C "$(LIBXCB)"
	make -C "$(LIBXCB)" install

$(LIBX11_LIB): $(LIBXPROTO) $(LIBXTRANS) $(LIBKBPROTO) $(LIBINPUTPROTO) $(LIBXCB_LIB) $(LIBX11)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(LIBX11)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure --prefix="$(X11)/iup_$(TARGET)" \
	  --host=$(TARGET) \
	  --enable-ipv6 \
	  --enable-static \
	  --disable-shared \
	  --enable-malloc0returnsnull
	make -C "$(LIBX11)"
	make -C "$(LIBX11)" install

$(LIBXRENDER): $(LIBX11_LIB) $(LIBRENDERPROTO) $(XRENDER)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XRENDER)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(XRENDER)" V=1
	make -C "$(XRENDER)" install

$(LIBXT): $(LIBX11_LIB) $(XT)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XT)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(XT)" V=1
	make -C "$(XT)" install

$(LIBICE): $(LIBXPROTO) $(LIBXTRANS) $(ICE)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(ICE)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(ICE)" V=1
	make -C "$(ICE)" install

$(LIBSM): $(LIBXPROTO) $(LIBXTRANS) $(SM)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(SM)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(SM)" V=1
	make -C "$(SM)" install

$(LIBXFT): $(LIBXRENDER) $(LIBFONTCONFIG) $(LIBFREETYPE) $(XFT)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XFT)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	XRENDER_CFLAGS="-I$(X11)/iup_$(TARGET)/include" \
	XRENDER_LIBS="-L$(X11)/iup_$(TARGET)/lib -lXrender" \
	FONTCONFIG_CFLAGS="-I$(X11)/iup_$(TARGET)/include" \
	FONTCONFIG_LIBS="-L$(X11)/iup_$(TARGET)/lib -lfontconfig" \
	FREETYPE_CFLAGS="-I$(FREETYPE)/include" \
	FREETYPE_LIBS="-L$(FREETYPE)/lib/$(TEC_UNAME) -lfreetype -lz" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(XFT)" V=1
	make -C "$(XFT)" install

$(LIBXPM): $(LIBXT) $(LIBXEXT) $(XPM)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XPM)" && \
	PKG_CONFIG_LIBDIR="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(XPM)" V=1
	make -C "$(XPM)" install

$(LIBXMU): $(LIBXT) $(LIBXEXT_LIB) $(XMU)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(XMU)" && \
	PKG_CONFIG_PATH="$(X11)/iup_$(TARGET)/lib/pkgconfig" \
	./configure \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --host="$(TARGET)" \
	  --disable-shared \
	  --enable-static \
	  --enable-malloc0returnsnull
	make -C "$(XMU)" V=1
	make -C "$(XMU)" install

$(LIBLUA): $(LUA)
	rm -rf "$(LUA)/lib/$(TEC_UNAME)"
	mkdir -p "$(LUA)/lib"
	cp -r "$(LUA)/src" "$(LUA)/lib/$(TEC_UNAME)"
	make -C "$(LUA)/lib/$(TEC_UNAME)" CC=$(TARGET_CC) liblua.a
	$(TARGET_RANLIB) "$(LUA)/lib/$(TEC_UNAME)/liblua.a"

$(LIBZLIB): $(ZLIB)
	make -C "$(ZLIB)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) depend
	make -C "$(ZLIB)/src" $(TECGRAF_BUILD_OPTIONS)

$(LIBFREETYPE): $(FREETYPE)
	make -C "$(FREETYPE)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="$(ZLIB)/include" depend
	make -C "$(FREETYPE)" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include"

$(LIBMOTIF): $(LIBXT) $(MOTIF)
	mkdir -p "$(X11)/iup_$(TARGET)"
	cd "$(MOTIF)" && \
	CFLAGS="-I$(X11)/iup_$(TARGET)/include" \
	LDFLAGS="-L$(X11)/iup_$(TARGET)/lib" \
	ac_cv_func_setpgrp_void=yes \
	./configure \
	  --host=$(TARGET) \
	  --disable-shared \
	  --enable-static \
	  --prefix="$(X11)/iup_$(TARGET)" \
	  --x-includes="$(X11)/iup_$(TARGET)/include" \
	  --x-libraries="$(X11)/iup_$(TARGET)/lib" \
	  --disable-build-tests \
	  --without-motif
	 make -C "$(MOTIF)"
	 make -C "$(MOTIF)" install

#ac_cv_func_setpgrp_void=yes \

ifneq (,$(findstring linux,$(TARGET))) #begin linux
$(LIBFTGL): $(LIBFREETYPE) $(LIBMESA) $(LIBGLU) $(LIBFONTCONFIG) $(FTGL)
endif
ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
$(LIBFTGL): $(LIBFREETYPE) $(FTGL)
endif
	make -C "$(FTGL)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="$(ZLIB)/include $(FREETYPE)/include $(X11)/iup_$(TARGET)/include" depend
	make -C "$(FTGL)" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(X11)/iup_$(TARGET)/include"

$(LIBIM): $(LIBZLIB) $(IM)/.extracted
	make -C "$(IM)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="$(ZLIB)/include" depend
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im

$(LIBIM_JP2): $(LIBIM)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im_jp2

$(LIBIM_PROCESS): $(LIBIM)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im_process

$(LIBIM_FFTW): $(LIBIM)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im_fftw

$(LIBIM_LZO): $(LIBIM)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im_lzo

$(LIBIM_PROCESS_OMP): $(LIBIM_PROCESS)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" im_process_omp

$(LIBIMLUA): $(LIBIM) $(LUA)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" imlua5

$(LIBIMLUA_JP2): $(LIBIM_JP2) $(LUA)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" imlua_jp25

$(LIBIMLUA_PROCESS): $(LIBIM_PROCESS) $(LUA)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" imlua_process5

$(LIBIMLUA_FFTW): $(LIBIM_FFTW) $(LUA)
	make -C "$(IM)/src" $(TECGRAF_BUILD_OPTIONS) EXTRAINCS="-I$(ZLIB)/include" imlua_fftw5

ifneq (,$(findstring linux,$(TARGET))) #begin linux
$(LIBCD): $(LIBIM) $(LIBX11_LIB) $(LIBFONTCONFIG) $(CD)/.extracted
endif
ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
$(LIBCD): $(LIBIM) $(LIBFTGL) $(CD)/.extracted
endif
	make -C "$(CD)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) FREETYPE_INC="$(FREETYPE)/include" IM_INC="$(IM)/include" EXTRAINCS="$(ZLIB)/include $(FTGL)/include" depend
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) FREETYPE_INC="$(FREETYPE)/include" IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FTGL)/include" cd

$(LIBCD_PDFLIB): $(LIBCD)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cd_pdflib

$(LIBCDPDF): $(LIBCD)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdpdf

ifneq (,$(findstring linux,$(TARGET))) #begin linux
$(LIBCDGL): $(LIBCD) $(LIBFTGL)
endif
ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
$(LIBCDGL): $(LIBCD)
endif
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdgl

$(LIBCDIM): $(LIBCD)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdim

ifneq (,$(findstring linux,$(TARGET))) #begin linux
$(LIBCDCONTEXTPLUS): $(LIBCD) $(LIBXRENDER) $(LIBXFT)
endif
ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
$(LIBCDCONTEXTPLUS): $(LIBCD)
endif
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdcontextplus

$(LIBCDLUA): $(LIBCD) $(LUA)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdlua5

$(LIBCDLUAPDF): $(LIBCD_PDFLIB) $(LUA)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdluapdf5

$(LIBCDLUAGL): $(LIBCDGL) $(LUA)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdluagl5

$(LIBCDLUACONTEXTPLUS): $(LIBCDCONTEXTPLUS) $(LUA)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdluacontextplus5

$(LIBCDLUAIM): $(LIBCDIM) $(LUA)
	make -C "$(CD)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FREETYPE)/include -I$(FTGL)/include" cdluaim5

ifneq (,$(findstring linux,$(TARGET))) #begin linux
$(LIBIUP): $(LIBCD) $(LIBXPM) $(LIBXMU) $(LIBXEXT) $(LIBXT) $(LIBX11_LIB) $(IUP)/.extracted
endif
ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
$(LIBIUP): $(LIBCD) $(IUP)/.extracted
endif
	make -C "$(IUP)/src" -f ../tecmake.mak $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="$(ZLIB)/include" depend
	make -C "$(IUP)/src" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iup

$(LIBIUPCD): $(LIBIUP)
	make -C "$(IUP)/srccd" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPCONTROLS): $(LIBIUP)
	make -C "$(IUP)/srccontrols" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPGL): $(LIBIUP)
	make -C "$(IUP)/srcgl" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPGLCONTROLS): $(LIBIUP)
	make -C "$(IUP)/srcglcontrols" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FTGL)/include"

$(LIBIUPMATRIXEX): $(LIBIUP)
	make -C "$(IUP)/srcmatrixex" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUP_PLOT): $(LIBIUP)
	make -C "$(IUP)/srcplot" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUP_MGLPLOT): $(LIBIUP)
	make -C "$(IUP)/srcmglplot" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUP_SCINTILLA): $(LIBIUP)
	make -C "$(IUP)/srcscintilla" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPIM): $(LIBIUP)
	make -C "$(IUP)/srcim" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPIMGLIB): $(LIBIUP)
	make -C "$(IUP)/srcimglib" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPOLE): $(LIBIUP)
	make -C "$(IUP)/srcole" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupole

$(LIBIUPTUIO): $(LIBIUP)
	make -C "$(IUP)/srctuio" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include"

$(LIBIUPLUA): $(LIBIUP) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iuplua

$(LIBIUPLUACD): $(LIBIUPCD) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluacd

$(LIBIUPLUACONTROLS): $(LIBIUPCONTROLS) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluacontrols

$(LIBIUPLUAMATRIXEX): $(LIBIUPMATRIXEX) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluamatrixex

$(LIBIUPLUAGL): $(LIBIUPGL) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluagl

$(LIBIUPLUAGLCONTROLS): $(LIBIUPGLCONTROLS) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include -I$(FTGL)/include" iupluaglcontrols

$(LIBIUPLUA_PLOT): $(LIBIUP_PLOT) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iuplua_plot

$(LIBIUPLUA_MGLPLOT): $(LIBIUP_MGLPLOT) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iuplua_mglplot

$(LIBIUPLUA_SCINTILLA): $(LIBIUP_SCINTILLA) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iuplua_scintilla

$(LIBIUPLUAIM): $(LIBIUPIM) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluaim

$(LIBIUPLUAIMGLIB): $(LIBIUPIMGLIB) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluaimglib

$(LIBIUPLUATUIO): $(LIBIUPTUIO) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluatuio

$(LIBIUPLUAOLE): $(LIBIUPOLE) $(LUA)
	make -C "$(IUP)/srclua5" $(TECGRAF_BUILD_OPTIONS) IM_INC="$(IM)/include" CD_INC="$(CD)/include" EXTRAINCS="-I$(ZLIB)/include" iupluaole

libim-all:

libcd-all:

libiup-all:

ifneq (,$(findstring mingw32,$(TARGET))) #begin windows
libim-all: \
	$(LIBIM) \
	$(LIBIM_JP2) \
	$(LIBIM_PROCESS) \
	$(LIBIM_FFTW) \
	$(LIBIM_LZO) \
	$(LIBIM_PROCESS_OMP) \
	$(LIBIMLUA) \
	$(LIBIMLUA_JP2) \
	$(LIBIMLUA_PROCESS) \
	$(LIBIMLUA_FFTW)

libcd-all: \
	$(LIBCD) \
	$(LIBCD_PDFLIB) \
	$(LIBCDPDF) \
	$(LIBCDGL) \
	$(LIBCDIM) \
	$(LIBCDCONTEXTPLUS) \
	$(LIBCDLUA) \
	$(LIBCDLUAPDF) \
	$(LIBCDLUAGL) \
	$(LIBCDLUACONTEXTPLUS) \
	$(LIBCDLUAIM)

libiup-all: \
	$(LIBIUP) \
	$(LIBIUPCD) \
	$(LIBIUPCONTROLS) \
	$(LIBIUPGL) \
	$(LIBIUPGLCONTROLS) \
	$(LIBIUPMATRIXEX) \
	$(LIBIUP_PLOT) \
	$(LIBIUP_MGLPLOT) \
	$(LIBIUP_SCINTILLA) \
	$(LIBIUPIM) \
	$(LIBIUPIMGLIB) \
	$(LIBIUPOLE) \
	$(LIBIUPTUIO) \
	$(LIBIUPLUA) \
	$(LIBIUPLUACD) \
	$(LIBIUPLUACONTROLS) \
	$(LIBIUPLUAMATRIXEX) \
	$(LIBIUPLUAGL) \
	$(LIBIUPLUAGLCONTROLS) \
	$(LIBIUPLUA_PLOT) \
	$(LIBIUPLUA_MGLPLOT) \
	$(LIBIUPLUA_SCINTILLA) \
	$(LIBIUPLUAIM) \
	$(LIBIUPLUAIMGLIB) \
	$(LIBIUPLUATUIO) \
	$(LIBIUPLUAOLE)
endif

ifneq (,$(findstring linux,$(TARGET))) #begin linux
libim-all: \
	$(LIBIM) \
	$(LIBIM_JP2) \
	$(LIBIM_PROCESS) \
	$(LIBIM_FFTW) \
	$(LIBIM_LZO) \
	$(LIBIM_PROCESS_OMP) \
	$(LIBIMLUA) \
	$(LIBIMLUA_JP2) \
	$(LIBIMLUA_PROCESS) \
	$(LIBIMLUA_FFTW)

libcd-all: \
	$(LIBCD) \
	$(LIBCDGL) \
	$(LIBCDIM) \
	$(LIBCDCONTEXTPLUS) \
	$(LIBCDLUA) \
	$(LIBCDLUAGL) \
	$(LIBCDLUACONTEXTPLUS) \
	$(LIBCDLUAIM)
endif

zlib: $(LIBZLIB)

dist-clean-x11:
	rm -rf "$(X11)"
	rm -rf "$(LIBX11)"
	rm -rf "$(LIBXAU)"
	rm -rf "$(LIBXCB)"
	rm -rf "$(XPROTO)"
	rm -rf "$(XTRANS)"
	rm -rf "$(INPUTPROTO)"
	rm -rf "$(KBPROTO)"
	rm -rf "$(DRI2PROTO)"
	rm -rf "$(EXPAT)"
	rm -rf "$(FONTCONFIG)"
	rm -rf "$(GLU)"
	rm -rf "$(GLPROTO)"
	rm -rf "$(LIBDRM)"
	rm -rf "$(LIBXEXT)"
	rm -rf "$(XEXTPROTO)"
	rm -rf "$(MESA)"
	rm -rf "$(ICE)"
	rm -rf "$(SM)"
	rm -rf "$(XFT)"
	rm -rf "$(XMU)"
	rm -rf "$(XPM)"
	rm -rf "$(XRENDER)"
	rm -rf "$(MOTIF)"
	rm -rf "$(RENDERPROTO)"
	rm -rf "$(XT)"

dist-clean-lua:
	rm -rf "$(LUA)"

dist-clean-zlib:
	rm -rf "$(ZLIB)"

dist-clean-freetype:
	rm -rf "$(FREETYPE)"

dist-clean-ftgl:
	rm -rf "$(FTGL)"

dist-clean-im:
	rm -rf "$(IM)"

dist-clean-cd:
	rm -rf "$(CD)"

dist-clean-iup:
	rm -rf "$(IUP)"

clean-x11:
	rm -rf "$(X11)/iup_$(TARGET)"

clean-lua:
	rm -rf "$(LUA)/$(TEC_UNAME)"

clean-zlib:
	rm -rf "$(ZLIB)/lib/$(TEC_UNAME)"
	rm -rf "$(ZLIB)/obj/$(TEC_UNAME)"

clean-freetype:
	rm -rf "$(FREETYPE)/lib/$(TEC_UNAME)"
	rm -rf "$(FREETYPE)/obj/freetype6/$(TEC_UNAME)"

clean-ftgl:
	rm -rf "$(FTGL)/lib/$(TEC_UNAME)"
	rm -rf "$(FTGL)/obj/$(TEC_UNAME)"

clean-im:
	rm -rf "$(IM)/lib/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/im_fftw/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/im_jp2/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/imlua$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/imlua_fftw$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/imlua_jp2$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/imlua_process$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/imlua_process_omp$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/im_lzo/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/im_process/$(TEC_UNAME)"
	rm -rf "$(IM)/obj/im_process_omp/$(TEC_UNAME)"

clean-cd:
	rm -rf "$(CD)/lib/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdcontextplus/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdgl/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdim/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdpdf/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/pdflib/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdlua$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdluacontextplus$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdluagl$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdluaim$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(CD)/obj/cdluapdf$(LUA_DLLVER)/$(TEC_UNAME)"

clean-iup:
	rm -rf "$(IUP)/lib/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupcd/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupcontrols/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupgl/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupglcontrols/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupim/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupimglib/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupmatrixex/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iup_mglplot/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupole/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iup_plot/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iup_scintilla/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iuptuio/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iuplua$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluacd$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluacontrols$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluagl$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluaglcontrols$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluaim$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluaimglib$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluamatrixex$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iuplua_mglplot$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluaole$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iuplua_plot$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iuplua_scintilla$(LUA_DLLVER)/$(TEC_UNAME)"
	rm -rf "$(IUP)/obj/iupluatuio$(LUA_DLLVER)/$(TEC_UNAME)"

all: libim-all libcd-all libiup-all

clean: clean-x11 clean-im clean-cd clean-iup clean-ftgl clean-freetype clean-zlib clean-lua

dist-clean: dist-clean-x11 dist-clean-im dist-clean-cd dist-clean-iup dist-clean-ftgl dist-clean-freetype dist-clean-zlib dist-clean-lua

