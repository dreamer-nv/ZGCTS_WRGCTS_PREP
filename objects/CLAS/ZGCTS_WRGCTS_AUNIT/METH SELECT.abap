  method SELECT.
    select BUKRS, WAERS from t001 into table @data(lt_t001).
  endmethod.