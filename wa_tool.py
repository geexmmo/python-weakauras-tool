import sys
from lupa.luajit21 import LuaRuntime

# watch out for lua include paths
python_path=sys.prefix

def run_lua(action: str, input_string: str) -> str:
    """
    Decode/Encode WeakAuras Lua strings using the provided Lua scripts.
    :param action: The action to perform. Must be either 'decode' or 'encode'.
    :param input_string: The WA2 or JSON string to decode or encode.
    :return: The decoded or encoded WA2 or JSON string.
    :raises ValueError: If an invalid action is provided.
    :raises FileNotFoundError: If the Lua script file is not found.
    :raises SyntaxError: If there is a syntax error in the Lua script.
    """
    lua_file = './lua/decode.lua' if action == 'decode' else './lua/encode.lua' if action == 'encode' else None
    if not lua_file:
        raise ValueError('Invalid action provided')
    try:
        lua = LuaRuntime(unpack_returned_tuples=True)
        lua_func = lua.eval(open(python_path + '/' + lua_file).read())
        lua_output = lua_func(input_string, python_path) #json string
        return lua_output #json string
    except (FileNotFoundError, SyntaxError) as error:
        return error

if __name__ == "__main__":
    input_string = sys.argv[1] if len(sys.argv) >= 2 else \
        "!WA:2!Lwv3YTnru4QiyyqZaK4MgAkLsOq)fiKK20cLHFIsTtCRJTJSYpT8t8kP1E3gzj1Dx58ZamKatNCDUP37RHB8JqEcoJhEcYf9bipbSRKCABggGz4MvN9SNDpNVZ35CK2Y54otp(K3E8jY1kNxoV9UqphK76ESWOzd9dz3txxVQ(eJpDhrOBBmJtddoR2F09qNqMhMzMzB0GM(0T3gX8gZom0xqJS4UiFSUtQDKoPFZ71ehnuThhJy4Xke77p2keQa3HHBkFy7TIWwnzHXrzMxJUn(vpIgiWSaK)YPU)PDtpmn(0000zBwPrdowOX2QVaYvinLFllUaXegonObuoXWu(rySRGrB2u(AN7YSmXN0Xd7e3OHkeyZNVu1clvYuOIhumdn1U8iSVFrpUXH8yhCBCGOM0A6MDxB2zQzVwn7zSSnJLpUtKpAlmZka1cZnSsm1zEmYxqo(Qvzy5vTQvnFPs7hhKfcgDrbUKqw1qjGDMnFz78whKc1uu96M(HiVcoczInqmIvRyzI2WugAUJaFKHLRpIZvsMCzEtjSpkG2cPYe3cYv4amIJRjy4GMcYRbJAgegG75jXNYI1uOLXXUHbE8DvMQYfWKMTq0GcWeYlatctb3aUP87PpPMls92xG5I5u0xpuSqIKkrjKGr3gmz2q6zKaPFukklOuP8GtTzTYNV8uXuVUlEJIxRyB3kwLXoY4ObTPHfYpIG07iZDwjfjCJ95y)gjzj4kDuHlnZn0GgHSu8AKvKumqM40Z5E99UAhQ02AHXmx85pf8wADrEpkMlWElG2CGNVHgmamOgCz4k9CLLYEHBeuBdAeU(b93QkIjMQxRoCM38YWipbEB4SYKX5G3Xaop8UWfG3dgZaEF4IWhaFiCjJOHufKTX2Pu9cHE4F)uWB80dJyHnzyopnUU(5p1aWNQ4QtMVN(FNbKvWCKqXMyc813zey0EYKMQBw1sf4T3Wr5e4nfRXjijmwnRvjA0eLjlPPV14zcWK7F8zx8s8ObFHR)8UVdt12NtmNzj7krNorPSmiuXhURq9eeZzKBpk1r0nXEjk3PxA9WdYcNdsoxXf0gBj5xwOqciBPsZYvkNhgLjbLYMojg62FiL((ziiqenybgD7Xwmg5PQ4gZ2(LaEFp1lr3gYYKvyOODxjtinaAt5uhFC9mm)cDMrdvSC58wRzwX2UYcwfNBE7Eh7A1aRrZq0QVKFuNMmCPYs2Lkwo)Z610pCJcm8JJXbUBv9vMy8PMofDQdoqTC3Swt9Dv7u3UNtSqegurojwoMPJsDPK25Z0vj3hA7R2C88B9dI5456RHKy5XbxYltOURhiRc1tUyTKj3MkrsIIsu5HdL4nZ0X5oemTjrSdCTcW1vtAGpoz9tswhxTgnO0RZK1vL0KroPkAabmGIWNPdFr3hM)M3FzFC72HBbMgWqYUad40gWWYbBhJeZTddBPfnC)wrvDXDPCKKQ8iGU6pt9hevuGBnj85WDIYj96Szxq25zjRNQBTrsXh8v6WxAWObQFTHjhToghnJAGQWsL5jWTnGzm2TV7QdFdCL9UkC3Kbiq(bGc9hwaZvhMNaf)ppsaUxYea4()VA6Hsz96Wc7nmuwdQi1vv2SclM0CcwqnWgwcwEhyfnyvzG(a4HsZ)w47sYOW3d)aSMguhqGtDWf8a8OqdnOjqEgq7xxcpcwxh8HwqWzGqnik9YpMamnGRdcDiMaThc2GaB(pvwaBrGTFbAFX2YXwRCnsuRBCcAh(XuF8tAWp)3WTtP4w4xQd7KXIWUe4xZym43sOQCT)Zv)R"
    testrun = run_lua('decode', input_string)
    print(testrun)