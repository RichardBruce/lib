# Third party library un-tar and compilation Makefile
CWD 	= $(shell pwd)

# SDL library for video output
# Might require libxv-dev installing
SDL2-$(SDL_VER) : SDL2-$(SDL_VER).tar.gz
	@echo "Unzipping SDL....."
	@tar xfz SDL2-$(SDL_VER).tar.gz
	@echo "Building SDL....."
	@(cd SDL2-$(SDL_VER)/ ; ./configure --silent --prefix $(CWD)/SDL2-$(SDL_VER) ; make -s ; make -s install)

# SDL TTF library for text rendering
SDL2_ttf-$(SDLTTF_VER) : SDL2_ttf-$(SDLTTF_VER).tar.gz freefont-ttf-$(FREEFONT_VER) freetype-$(FREETYPE_VER)
	@echo "Unzipping SDL TTF....."
	@tar xfz SDL2_ttf-$(SDLTTF_VER).tar.gz
	@echo "Building SDL TTF....."
	@(cd SDL2_ttf-$(SDLTTF_VER)/ ; ./configure --silent --prefix $(CWD)/SDL2_ttf-$(SDLTTF_VER) --with-freetype-prefix=$(CWD)/freetype-$(FREETYPE_VER) --with-sdl-prefix=$(CWD)/SDL2-$(SDL_VER); make -s ; make -s install)

# SDL image library for loading images to SDL
SDL2_image-$(SDLIMAGE_VER) : SDL2_image-$(SDLIMAGE_VER).tar.gz SDL2-$(SDL_VER)
	@echo "Unzipping SDL Image....."
	@tar xfz SDL2_image-$(SDLIMAGE_VER).tar.gz
	@echo "Building SDL Image....."
	@(cd SDL2_image-$(SDLIMAGE_VER)/ ; ./configure --silent --prefix $(CWD)/SDL2_image-$(SDLIMAGE_VER); make -s ; make -s install)

# FreeFont library for text rendering
freefont-ttf-$(FREEFONT_VER) : freefont-ttf-$(FREEFONT_VER).tar.gz
	@echo "Unzipping FreeFont....."
	@tar xfz freefont-ttf-$(FREEFONT_VER).tar.gz

# FreeType library for text rendering
freetype-$(FREETYPE_VER) : freetype-$(FREETYPE_VER).tar.gz
	@echo "Unzipping FreeType....."
	@tar xfz freetype-$(FREETYPE_VER).tar.gz
	@echo "Building FreeType....."
	@(cd freetype-$(FREETYPE_VER)/ ; ./configure --silent --prefix $(CWD)/freetype-$(FREETYPE_VER) ; make -s ; make -s install)

# TBB library for threading
tbb$(TBB_VER) : tbb$(TBB_VER)_src.tgz
	@echo "Unzipping TBB....."
	@tar xfz tbb$(TBB_VER)_src.tgz
	@echo "Building TBB..."
	@(cd tbb$(TBB_VER)/ ; make -s work_dir=./build/build )

# FFTW for optimised FFT implementation
fftw-$(FFTW_VER) : fftw-$(FFTW_VER).tar.gz
	@echo "Unzipping fftw-$(FFTW_VER)....."
	@tar xfz fftw-$(FFTW_VER).tar.gz
	@echo "Building fftw-$(FFTW_VER)....."
	@(cd fftw-$(FFTW_VER)/ ; ./configure --silent --prefix $(CWD)/fftw-$(FFTW_VER) --enable-float ; make -s ; make -s install)

# FFmpeg for optimised video encoding
ffmpeg : ffmpeg.tar.gz
	@echo "Unzipping ffmpeg....."
	@tar xfz ffmpeg.tar.gz
	@echo "Building ffmpeg....."
	@(cd ffmpeg/ ; ./configure --prefix=$(CWD)/ffmpeg --disable-indev=v4l --disable-indev=v4l2 --enable-memalign-hack ; make -s ; make -s install)

# FFmpeg for optimised video encoding
libtga-$(LIBTGA_VER) : libtga-$(LIBTGA_VER).tar.gz
	@echo "Unzipping libtga....."
	@tar xfz libtga-$(LIBTGA_VER).tar.gz
	@echo "Building libtga....."
	@(cd libtga-$(LIBTGA_VER)/ ; ./configure --prefix=$(CWD)/libtga-$(LIBTGA_VER) ; make -s ; make -s install)
        
# SPD for test scenes
spd$(SPD_VER) : spd$(SPD_VER).tar.gz
	@echo "Unzipping spd$(SPD_VER)....."
	@tar xfz spd$(SPD_VER).tar.gz
	@echo "Building spd$(SPD_VER)....."
	@( cd spd$(SPD_VER) ; make -s all )

SPD : $(LIBARYS_PATH)/spd$(SPD_VER)
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/balls_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/gears_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/jacks_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/lattice_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/mount_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/nurbtst_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/rings_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/sample_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/shells_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/sombrero_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/teapot_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/tetra_scenes
	@mkdir $(RAPTOR_DATA)/spd$(SPD_VER)/tree_scenes
	@echo "Generating spd$(SPD_VER) scenes....."
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/balls    balls_scenes    ; cd balls_scenes    ; ./balls    -r 1 -s  1 -t  9 > balls_1.nff    ; ./balls    -r 1 -s  2 -t  9 > balls_2.nff    ; ./balls    -r 1 -s  3 -t  9 > balls_3.nff    ; ./balls    -r 1 -s   4 -t  9 > balls_4.nff    )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/gears    gears_scenes    ; cd gears_scenes    ; ./gears    -r 1 -s  2       > gears_2.nff    ; ./gears    -r 1 -s  5       > gears_5.nff    ; ./gears    -r 1 -s  12      > gears_12.nff   ; ./gears    -r 1 -s  25       > gears_25.nff   )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/jacks    jacks_scenes    ; cd jacks_scenes    ; ./jacks    -r 1 -s  2 -t  9 > jacks_2.nff    ; ./jacks    -r 1 -s  3 -t  9 > jacks_3.nff    ; ./jacks    -r 1 -s  4 -t  9 > jacks_4.nff    ; ./jacks    -r 1 -s   5 -t  9 > jacks_5.nff    )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/lattice  lattice_scenes  ; cd lattice_scenes  ; ./lattice  -r 1 -s  1 -t  9 > lattice_1.nff  ; ./lattice  -r 1 -s  3 -t  9 > lattice_3.nff  ; ./lattice  -r 1 -s  8 -t  9 > lattice_8.nff  ; ./lattice  -r 1 -s  19 -t  9 > lattice_19.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/mount    mount_scenes    ; cd mount_scenes    ; ./mount    -r 1 -s  4 -t 14 > mount_4.nff    ; ./mount    -r 1 -s  7 -t 14 > mount_7.nff    ; ./mount    -r 1 -s  9 -t 14 > mount_9.nff    ; ./mount    -r 1 -s   9 -t 11 > mount_11.nff   )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/nurbtst  nurbtst_scenes  ; cd nurbtst_scenes  ; ./nurbtst  -r 1 -s  1       > nurbtst_1.nff  )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/rings    rings_scenes    ; cd rings_scenes    ; ./rings    -r 1 -s  1 -t  4 > rings_1.nff    ; ./rings    -r 1 -s  2 -t  7 > rings_2.nff    ; ./rings    -r 1 -s  4 -t  9 > rings_4.nff    ; ./rings    -r 1 -s   9 -t  9 > rings_9.nff    )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/sample   sample_scenes   ; cd sample_scenes   ; ./sample   -r 1 -s  1 -t 25 > sample_1.nff   )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/shells   shells_scenes   ; cd shells_scenes   ; ./shells   -r 1 -s  1 -t    > shells_1.nff   ; ./shells   -r 1 -s  2 -t    > shells_2.nff   ; ./shells   -r 1 -s   5 -t   > shells_5.nff   ; ./shells   -r 1 -s   9 -t    > shells_9.nff   )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/sombrero sombrero_scenes ; cd sombrero_scenes ; ./sombrero -r 1 -s  2       > sombrero_2.nff ; ./sombrero -r 1 -s  3       > sombrero_3.nff ; ./sombrero -r 1 -s   5      > sombrero_5.nff ; ./sombrero -r 1 -s   7       > sombrero_7.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/teapot   teapot_scenes   ; cd teapot_scenes   ; ./teapot   -r 1 -s 12       > teapot_12.nff  ; ./teapot   -r 1 -s 38       > teapot_38.nff  ; ./teapot   -r 1 -s 123      > teapot_123.nff ; ./teapot   -r 1 -s 389       > teapot_389.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/tetra    tetra_scenes    ; cd tetra_scenes    ; ./tetra    -r 1 -s  6       > tetra_6.nff    ; ./tetra    -r 1 -s  8       > tetra_8.nff    ; ./tetra    -r 1 -s   9      > tetra_9.nff    ; ./tetra    -r 1 -s  11       > tetra_11.nff   )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER) ; cp $(LIBARYS_PATH)/spd$(SPD_VER)/tree     tree_scenes     ; cd tree_scenes     ; ./tree     -r 1 -s  4 -t 4  > tree_4.nff     ; ./tree     -r 1 -s  5 -t 9  > tree_7.nff     ; ./tree     -r 1 -s  10 -t 6 > tree_10.nff    ; ./tree     -r 1 -s  14 -t  4 > tree_14.nff    )
	@echo "Editting spd$(SPD_VER) resolutions....."
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER)/jacks_scenes ; change_resolution.pl --format nff --x_res 640 --y_res 480 --file jacks_2.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER)/jacks_scenes ; change_resolution.pl --format nff --x_res 640 --y_res 480 --file jacks_3.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER)/jacks_scenes ; change_resolution.pl --format nff --x_res 640 --y_res 480 --file jacks_4.nff )
	@( cd $(RAPTOR_DATA)/spd$(SPD_VER)/jacks_scenes ; change_resolution.pl --format nff --x_res 640 --y_res 480 --file jacks_5.nff )

# Boost c++ libraries for c++ utilities
boost_$(BOOST_VER) : boost_$(BOOST_VER).tar.bz2
	@echo "Unzipping boost....."
	@tar xfj boost_$(BOOST_VER).tar.bz2
	@echo "Building boost....."
	@(cd boost_$(BOOST_VER)/tools/build/v2 ; ./bootstrap.sh ; ./b2 install --prefix=./ -d0)
	@(cd boost_$(BOOST_VER) ; ./bootstrap.sh variant=release --with-libraries=log,serialization,system,test --prefix=./ ; ./b2 -d0 -j8 install)
        
all :	SDL2-$(SDL_VER) SDL2_ttf-$(SDLTTF_VER) SDL2_image-$(SDLIMAGE_VER) freefont-$(FREEFONT_VER) freetype-$(FREETYPE_VER) tbb$(TBB_VER) fftw-$(FFTW_VER) ffmpeg libtga-$(LIBTGA_VER) spd$(SPD_VER) SPD boost_$(BOOST_VER)

# Clean targets
clean ::
	$(RM) -r SDL2-$(SDL_VER)
	$(RM) -r SDL2_ttf-$(SDLTTF_VER)
	$(RM) -r SDL2_image-$(SDLIMAGE_VER)
	$(RM) -r freefont-$(FREEFONT_VER)
	$(RM) -r freetype-$(FREETYPE_VER)
	$(RM) -r tbb$(TBB_VER)
	$(RM) -r fftw-$(FFTW_VER)
	$(RM) -r ffmpeg
	$(RM) -r spd$(SPD_VER)
	$(RM) -r boost_$(BOOST_VER)

spotless ::
	$(RM) -r SDL2-$(SDL_VER)
	$(RM) -r SDL2_ttf-$(SDLTTF_VER)
	$(RM) -r SDL2_image-$(SDLIMAGE_VER)
	$(RM) -r freefont-$(FREEFONT_VER)
	$(RM) -r freetype-$(FREETYPE_VER)
	$(RM) -r tbb$(TBB_VER)
	$(RM) -r fftw-$(FFTW_VER)
	$(RM) -r ffmpeg
	$(RM) -r spd$(SPD_VER)
	$(RM) -r $(RAPTOR_DATA)/spd$(SPD_VER)/
	$(RM) -r boost_$(BOOST_VER)
