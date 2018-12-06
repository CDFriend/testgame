#include <sstream>
#include <exception>

class BaseError : public std::exception
{
    public:
        BaseError(const char* msg)
            : m_pMsg(msg)
        {}

        const char *what() const throw()
        {
            std::ostringstream ss;
            ss << GetErrorName_() << ":" << m_pMsg;
            return ss.str().c_str();
        }

    private:
        virtual const char* GetErrorName_() const { return "BaseError"; }

        const char* m_pMsg;
};

class SdlError : public BaseError
{
    public:
        SdlError(const char *msg) : BaseError(msg) {}
    private:
        virtual const char* GetErrorName_() const { return "SDLError"; }
};
