import MetaTrader5 as mt5, json, sys

if not mt5.initialize():
    print(json.dumps({"error":"MT5 init failed"})); sys.exit(1)

symbol = "XAUUSDm"
info = mt5.symbol_info(symbol)
if info is None:
    print(json.dumps({"error":f"{symbol} not in MarketWatch"})); mt5.shutdown(); sys.exit(1)
if not info.visible:
    mt5.symbol_select(symbol, True)

tick = mt5.symbol_info_tick(symbol)
if tick is None:
    print(json.dumps({"error":f"No tick for {symbol}"})); mt5.shutdown(); sys.exit(1)

ticks = mt5.copy_ticks_from(symbol, tick.time, 10, mt5.COPY_TICKS_ALL)
mt5.shutdown()

out = [{"symbol":symbol, "bid":float(t["bid"]), "ask":float(t["ask"]), "time":int(t["time"])} for t in ticks]
print(json.dumps(out))
