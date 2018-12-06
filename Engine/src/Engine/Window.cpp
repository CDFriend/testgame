#include <Engine/Error.h>
#include <Engine/Window.h>
#include <sdl2/SDL.h>

namespace Engine
{

    namespace Detail
    {
        void InitSdl()
        {
            if (SDL_Init(SDL_INIT_VIDEO) < 0)
                throw SdlError("SDL failed to initialize!");
        }

        void DeinitSdl()
        {
            SDL_Quit();
        }
    }

    static unsigned int numActiveWindows = 0;

    Window::Window(int width, int height, bool bShown)
    {
        // If this is the first active window, initialize SDL
        if (numActiveWindows++ == 0)
            Detail::InitSdl();
    }

    Window::~Window()
    {
        // If no more active windows, deinit SDL
        if (--numActiveWindows == 0)
            Detail::DeinitSdl();
    }

}
