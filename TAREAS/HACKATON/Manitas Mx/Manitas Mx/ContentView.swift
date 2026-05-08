//
//  ContentView.swift
//  Manitas Mx
//

import SwiftUI
import AVFoundation
import Vision
import CoreHaptics
import AudioToolbox
import Combine

let GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
let APP_NAME = "Manitas Mx"

// MARK: - API Key Pool
final class GeminiKeyPool {
    static let shared = GeminiKeyPool()
    
    private let keys: [String] = [
        "AIzaSyD1F-GMw-i7_zDh_pn5EOYdPuYENEFHP1M",
        "AIzaSyCDdiDJRS4N9KI7PB8nv0DxHL6ZXMkd0L4",
        "AIzaSyBn52DVOh2f6vo91VtSlOVPuPXM7SAsqB0",
        "AIzaSyCK9IacpkOfzMXfLgGQ8MDBDexRXW6Petg",
        "AIzaSyDS_ua1tsnOLWvoNxOkkpF1bu1ANCRPI3s",
        "AIzaSyAh4katNDhsQNX8ht0s02tUrYb4HR0umTs",
        "AIzaSyAPeWjNP5tR20hPIlZJmVi1eVhNyPXYr2I",
        "AIzaSyC4RF0xbQXeSWMeTroRM9P9-qtitsl37mY",
        "AIzaSyAB8IEgHpDLP_wkxoDHKHtPCauctdUYopA",
        "AIzaSyC_kwkIRgRy5nQPgWHqqjpPaI5uHAxw_Y8",
        "AIzaSyAxWi4O3BFgON1fStdmQLXTGXCQHg8U5ZU",
        "AIzaSyA49NvdsAWezYUbVaxDWoKzvFv9DOvXd4E",
        "AIzaSyCWdSP4BnwTnVGulxgm6oPWiIap8TNuMno",
        "AIzaSyDWEeo9Zes9q8F8XJSEjtVqnAttxjNx5X4",
        "AIzaSyC2WHsZm-uedqWWXW2JiyL9Loe6gE8Lrzk",
        "AIzaSyA5b8-ewFy9p3jNxAktppJVg_sDeYM10kw",
        "AIzaSyBZg2wA30RrQCkxet3iZ4KSxKyCz5jNIIw",
        "AIzaSyD4pwcsKd89C1XsVij5wf2c3gxt8mlUgEs",
        "AIzaSyC5wJ-GH7r5PZQV3tNtCIy65ce3HD7hyYc",
        "AIzaSyCCMEm6m8azEmmOh8gcMnyonYh8mhWpBwE",
        "AIzaSyC4isCkqCi3sNv6JzjS5VIRHzaFphKDrbs",
        "AIzaSyCGuYDHIVaxVmZCb5Fbh7P6PS8gx_Cv2jc",
        "AIzaSyD8fi08iTJ01qDcSoC-_Bp76cxyAEUfauE",
        "AIzaSyA3xtoXrNVcMQ0NQ1_UABEZgM9cLj-Xo-I",
        "AIzaSyA_jl5FE9zaxihjTzMr7WzuWZB7KWydsQg",
        "AIzaSyC343ISrnTpkJwdGqzgi54X5wh2VQeFkQ0",
        "AIzaSyB4Aq8zwyZnolfY9IFVa6M9-BaJATnFTTI",
        "AIzaSyDNlzqll8UU7QRqsqSWqRoD8CV6E2coh4g",
        "AIzaSyCVf8hyS0L4DwCb-agjLTnP1uVsdMhp3H0",
        "AIzaSyDAtdeEcOdOSn_2oynY3E8Bp0wlLCtdmR4",
        "AIzaSyBJEfmTB7Os_WcrKVHInjKN9yW4W0AVkXs",
        "AIzaSyAb4ujsMFhJrA0hXd3Z1PkhpTCj7BwaIh8",
        "AIzaSyD1-6-9TlS9LiQ2cNItqiHEVQYKApwY7y4",
        "AIzaSyBHOIc8-i68k6aNQoEt9RB5bbUG_LlaRuE",
        "AIzaSyB-Ry0UA9SqIns9oCbybeByBHIf_q6r2MA",
        "AIzaSyA-8b_98bnAGhmCshs2eUHO6vAebLRXbkE",
        "AIzaSyAbet_2iJUEbdUI0niqGZOa_k82c6khzfE",
        "AIzaSyDLscat6QdNUlezHV1b7x5CSsDT6pWKjHo",
        "AIzaSyCz24kyL4w0W-zXr5xnQIecyzgaZrzAbok",
        "AIzaSyBv2jLg73vmu6hRT4OrDCKolS0pUXq5GJs",
        "AIzaSyCfJsB-8VkYcgNZt7likhu1SmfW3NMP6L4",
        "AIzaSyCNA38QcZf5L1JHs-n2a4y8KB6gD6SBV3M",
        "AIzaSyBR-Knkdb3eQL64XeHlGzCsy28xeLsE-pY",
        "AIzaSyBLO27D5zwtMMro3wHhCy7zijvPYPz19AI",
        "AIzaSyAApHH4449AJ2mT91yiuac1bXe3LRroD0w",
        "AIzaSyBRxesKZwT-CqVLW63uEZWnFzphBry8tgU",
        "AIzaSyCNv1_cMn4ADDDf0djZpFxTFaaQX1Vt17w",
        "AIzaSyDQerZQhbV5Q-5EHTJRNfbksAgsh6mW_wU",
        "AIzaSyB9pblDh_d9OOn-tLOhPhOvkHxa1Hh_HBw",
        "AIzaSyBTy3ehxJvBk6Wiu8QNPz1LlA7WhuITS9o",
        "AIzaSyB9UZlPBd6vengoOyx9rzT-rGP9o9R1294",
        "AIzaSyCmrLtPcgRQI5LEKThuNHD0He2Rbf1Ovgg",
        "AIzaSyDF3b_-x7qF1XLQ9WKBWnbO_C4VbaYmleY",
        "AIzaSyD0PIfHG2mymUEIz_aP0_1erFl1DoD2xIQ",
        "AIzaSyDnul5y8PTXPTB1jlWiQHyffuaESC8h5x4",
        "AIzaSyBMqCRA6twywl9vP3aHRdSkzcv2TYNkL30",
        "AIzaSyBn7neu_f8Kt326CQdqNoUq9XKFgV54lSc",
        "AIzaSyAV-S1edCaW8zsHKcQryHxddh-VXCoi9BU",
        "AIzaSyAm4MZOlWrzV2AEifGGrg7qL-iik69Jy6k",
        "AIzaSyBFfNORoh7vN6BqOa408YiyR-XYd4t5HrM",
        "AIzaSyDq5qalma2O-7fXRVV9f4G0QyNIWYUMYmI",
        "AIzaSyAGBXkV-713ECz6pzqbd0rXek_o7IJT9js",
        "AIzaSyC4UFHFvtlqz-u-lxkNvQvx1iJ7CJXEemA",
        "AIzaSyArgusrNeHtSXlxLnGCYdM0Kh61ERGF3B0",
        "AIzaSyDGWuFPHaqf0k5f9eM76eSQApSPr8--uhU",
        "AIzaSyAsf7amQHgAmpdZuWjrwE9MyXKk3lNzJJ8",
        "AIzaSyBtDAxMpO88G0htNceBWf2ZqTuHG7jpZ8Q",
        "AIzaSyAMh_wud_GP0a3_rfoVWTvxtQQsXv4VlKg",
        "AIzaSyD9wxrpO4czp5cfFD60mnQIMxFKNc9XBTI",
        "AIzaSyBBdLOnWGoGTgxA5OiaqfZIhkQoM4NsrsQ",
        "AIzaSyDEI1XqQDUp6Vy-seMkMYrtxXZfUjvHK1g",
        "AIzaSyD5gCgNxzPvTMvnD_2uROumHLwPM03JbbA",
        "AIzaSyDCwc0k5V6d3azejkTMpvKBnZt8XmpNHSE",
        "AIzaSyAUh13ocK4G7WP4DAuq6EiuU5zRZIpJy9w",
        "AIzaSyA-80L45Vxi2K3l3Q-Bh6MXPxAh1-piLy4",
        "AIzaSyCWT_Ku8BCqAR8j2UopVahRmHpMr7IlRCI",
        "AIzaSyC_sEQ9E3x_uAPLByzer68ZkMnGRxk864I",
        "AIzaSyC_AENfCgiTiSKZT22L1PomdGasGMnwdQA",
        "AIzaSyBwoc-9WDynUIlqiN_1HUi93qPvlNWOjAw",
        "AIzaSyBqaTu7zBU_F9Zsb14DN-YRgjC9vHWtYbE",
        "AIzaSyBpgmfeF2i5aYVT_W5xSBwvl9r7dRPM_dU",
        "AIzaSyA1GY6KqrLTr5KyMu4DEG072zcIjnxeQR8",
        "AIzaSyD2mDiS5-6A9gKwU1Rs9iNd8KFLyLF9IDg",
        "AIzaSyDLJoG5o5lPp8iw59nGaP3Hxjf4RwO1VCM",
        "AIzaSyBe9P7NmUnppBEpIbuPoSwff14ldXXRqqQ",
        "AIzaSyC2quolOmTPJe0jwAvZCHIz6QbM2kHrBsg",
        "AIzaSyBZKtoI5-SVk_cBbTPESG6ULrbRSho9HN0",
        "AIzaSyA2UsednNmDqPrRuqC4Y5X6aOqfy9qgSVM",
        "AIzaSyBULKhlGmDifv_NZ5JQTimaefP7X6HJxbk",
        "AIzaSyCc7vwhDxug3W-2tA8DHLTvBG3aszdsvF8",
        "AIzaSyBwfkZZ7J_oVaXscSEKX5soc0qpZkfxUxY",
        "AIzaSyDV3ZOnsN2PeWjRGCCuSZeDu9Vj0gQWKO4",
        "AIzaSyA7XUDmMR9QR4FTYAjhlglo0yE96p_Y8Wo",
        "AIzaSyATrC1mQyQpIY0bAUC0JFFpnQW4PWx7JD0",
        "AIzaSyBiVCEVBXSxAlXVgR2TAhT_Ruysnxsk7xk",
        "AIzaSyD9WQDQqYj3BclZX3G5ydRYQqLo1Ald2JE",
        "AIzaSyAnVSvyerby2VpZRLlT1qzwPHI1oicjkVQ",
        "AIzaSyCu7q7_iU7qvaf7moG8G4554GiNaNgfEe8",
        "AIzaSyDeJgwf2TtODrWQZDed-ptLa6vL5Lf8RD8",
        "AIzaSyCeE9lZjPa1rIM0ZcJMSpxy55_2-DtojxE",
        "AIzaSyAsxLAjp8QmcLRjsPFSTKY3Qc6bbQwVnEc",
        "AIzaSyDpZaNQgnAno7fhi4qKTNUCbh2_5fuMZBY",
        "AIzaSyAhjmotTd-R5hCoAK_KTX6dE_HDd9bedIU",
        "AIzaSyCUxQJyeHmF0TVHVRS3bKdL087Wv-l0ifQ",
        "AIzaSyCibB4ucVwbXy83vHhfi40JsBKCnJu2epc",
        "AIzaSyAiIkZb8x9FBR34mO8GY_NhJ1OlP2lWqUk",
        "AIzaSyAcdiTpX-8n91AEgtAJprFJwF6nflEFgcc",
        "AIzaSyBegsufz1TBZkkn5c99XH8L9PUcOk8zM20",
        "AIzaSyCYeCYrrk2Gn97yBrAjQlTu1Vkpsmt5r_M",
        "AIzaSyD9FhctXXNkqI_Q3GrXzdWTzB5HX3R3uZU",
        "AIzaSyAGNt9ZR0TvTX3yQwJVkig9ptPqHu0xtew",
        "AIzaSyBn0ESQaV8f1e7wjUa1SMdgi0CwsPPK3pM",
        "AIzaSyCtWdLwR92pfhVU0vKVvw7-yGKxmwYrw6w",
        "AIzaSyARpi-vOQzwhyLd09PjGd9dvK7zsLwtTFc",
        "AIzaSyDqUMPdfgvu8gJdKV34dVptynB8nBf1e3I",
        "AIzaSyD8p67gH0W_igs3ezYsXZ8krnhX7cXH0gc",
        "AIzaSyB6gp8txoL9sXe1ETBR9c2BEWUXvRaNdnw",
        "AIzaSyD7tCKQP2kxSX6_eYdQxY8MzD7UoGBqPUw",
        "AIzaSyBF5pTT3lQy2AUJEw9jEiPJdmTNUc-41-8",
        "AIzaSyB9VdX3MDuG7x3jwH-grJMRkC-yKY_lu_8",
        "AIzaSyBelKDsWSeHJeNl7mToSEhsXvIm-HxA4OM",
        "AIzaSyBH2eCU9gVGSxp8Utaa06AZkiQRGmERSA4",
        "AIzaSyD7sByzsWwRVDZa49hRUW_V-Vr4gpkwIJs",
        "AIzaSyBSZfeyFM8bbR3dcHAMSPt_rSzeOjX2DPs",
        "AIzaSyC4uk7DiV26SNuyHyBO94hB8xv9DJ5OLLM",
        "AIzaSyDtHhim74hWIAF_cSug2InxFdKi30oWoZ4",
        "AIzaSyApl3nP8vSgH4LN0kkiM0GOgQ4nkj5Y650",
        "AIzaSyD4OcPVJqPocDb-i309vzJdwhz33PzM3fI",
        "AIzaSyCZlwNir5RhuZuQ4m60HJzb8qnlqkk3HOg",
        "AIzaSyBlNmdsZGiDw5dfdojMCBqLutuQuG-Jw5Y",
        "AIzaSyC94v-n2pw4Lpn60MBx7AI_40DFEAMCIJU",
        "AIzaSyCbTNhp5q1A7c3xKTKrclCkTTcafuws00s",
        "AIzaSyDHQxJbSnZ0WdjdD5GulYtjqq2OfkY2UiI",
        "AIzaSyABAoD9G8T2_7ij0pCRPps6YmUyiLeU5E8",
        "AIzaSyAaWevPDLhXZPz8b1oiYZdPS66XFFSjCiU",
        "AIzaSyAmrRP1DsrG4f6V100ZKdNhxk4omaUOKio",
        "AIzaSyDvyoC-Wk7hI2V4AMPwRqVy-yXLlBSNHQ4",
        "AIzaSyAbye4bhfjAOjp3wfRasal39Ja9mVUaXn8",
        "AIzaSyAfvmzfUIJbs-DFGZNUtKrgBJgQWSC_jAM",
        "AIzaSyDzGT7XNIAFioXCCLxUPbg96gcIU-1pwco",
        "AIzaSyA4YVl1FyioXHA2VSQW7NaLM_b2VvEztHQ",
        "AIzaSyDpFk-g8FxYhp7Esb2Mz47dh5wcynD2kcM",
        "AIzaSyCAxrnRwXVOiiCaTeqNTvs8Jkntiou0_Ng",
        "AIzaSyBeOiqJgtowCsyga1VRo2HeWkxbtz5QUCM",
        "AIzaSyB-KH3l5UthZi9l_5V0MyTaxS4kZJR3xEA",
        "AIzaSyBhYbXCs__q0KqM1RaIvvcGvt3El79A1nU",
        "AIzaSyCZYkL1U2QPN6p5CiYR-GjT1GYf0AhO75g",
        "AIzaSyD-Il88VPovdu0JRHm_ChUcu_Sder6xuf0",
        "AIzaSyBWDITz0U9Prl3ByqyGGoGPewW6r4nV3ak",
        "AIzaSyAnZdLbAxBDHnds25w9f64mnA9_QEK5IUE",
        "AIzaSyDIlR857k4FJpne9Oi89tAxYF953YaqPUo",
        "AIzaSyBXlh1DgC9wooMYXK1ZoyG1d6Oq2CudQ2g",
        "AIzaSyCeKM-zH79vJXplimo9BzhmcgSZ3za8kQ4",
        "AIzaSyApC2TFu-l81uoiCHg0YuIDrRPEHo4YgPQ",
        "AIzaSyCRAE_KXKjIWrXkPFLofKvOuQRtCFxEEt4",
        "AIzaSyAKTXtLytzhqrt9lv8wxJQUFDdxFrX_2zY",
        "AIzaSyCBpnVPgdeaMhpAlwBeXOev65vqhO1rMgA",
        "AIzaSyAQf1fSbU50jwbDp1yQcphb1uhOjn_Ohfg",
        "AIzaSyDgukdW4kU7BP9qCz2TRWrq17eogA7SYKk",
        "AIzaSyBm1nniyCGUUkt7aHuykxtCLddd83dL7kI",
        "AIzaSyBJMcUm9izAjXr1CJdMaAJwIlIBdw_CQEw",
        "AIzaSyAwxw_kgbzE52qrOdO5lexZedCADn6xc9U",
        "AIzaSyCuUWJPkTwKjVUkT-29WfuyWlW7EdJ9uos",
        "AIzaSyCWBpaHO_AluuGPSxQUGehxUrny3LXfFbs",
        "AIzaSyBL_UYPifEof9yFGWVmqBrhYySYPLTTB5A",
        "AIzaSyAPlMYsRS_jLN10BqGNh1_lLUp4cZUtnKg",
        "AIzaSyC_JWdz3uhHGrHj7B4iNE2_1QI8asegl4M",
        "AIzaSyBLWio5mVnOwXBCcnqz18g9RrFXson80rs",
        "AIzaSyCq65kg_MZyU4oro-LzBDmhc1g_Rmr2uAg",
        "AIzaSyAhkZHE0QJBkPqN0v2sDeV6vz030JPeWvM",
        "AIzaSyCg0TEBrVliZskmFzdsc6YMKxuX-wZtTR4",
        "AIzaSyAB0WeV_TSHRQP4LgXBSLO7CluFJfd_XYc",
        "AIzaSyC5vga-ZYU8rtNVj5mWHGK2uJp50-nN2Sg",
        "AIzaSyBfDkAFH7bqT6CnLJts7UDsf-4EgLsRPvo",
        "AIzaSyAiAMKH5pJqTL1hgCq5Qd4yWiWJAVc913k",
        "AIzaSyBXnnWKP3EdmTyoZxHw2lXzkWagZnhIfB4",
        "AIzaSyCa8EyZ0uK3WQRPqyaz0rFPCT1_qRp5lbo",
        "AIzaSyD6bVXQlUP3htGeSnfneMEV6mtTQvP95aw",
        "AIzaSyD5tqNqwx9LZtXdZmysS1Aqa4zlg8rfQnA",
        ]

    private var currentIndex = 0
    private var failedKeys = Set<String>()
    private let lock = NSLock()

    var current: String {
        lock.lock(); defer { lock.unlock() }
        return keys[currentIndex]
    }

    func rotateOnFailure(_ failedKey: String) -> String? {
        lock.lock(); defer { lock.unlock() }
        failedKeys.insert(failedKey)
        for i in 1...keys.count {
            let nextIndex = (currentIndex + i) % keys.count
            if !failedKeys.contains(keys[nextIndex]) {
                currentIndex = nextIndex
                print("🔄 Rotando a key \(nextIndex + 1)/\(keys.count)")
                return keys[nextIndex]
            }
        }
        print("⚠️ Todas las keys fallaron, reseteando pool...")
        failedKeys.removeAll()
        currentIndex = 0
        return keys[0]
    }

    var availableCount: Int { keys.count - failedKeys.count }
}

// MARK: - Result Cache
final class ResultCache {
    static let shared = ResultCache()
    private var cache: [String: LSMResult] = [:]
    private let maxSize = 50

    func key(from handDescription: String) -> String {
        let lines = handDescription.components(separatedBy: "\n")
        let stateLines = lines.filter {
            $0.contains("EXTENDIDO") || $0.contains("DOBLADO") || $0.contains("PATRÓN")
        }
        return stateLines.joined(separator: "|")
    }

    func get(_ key: String) -> LSMResult? { cache[key] }

    func set(_ key: String, result: LSMResult) {
        if cache.count >= maxSize { cache.removeAll() }
        cache[key] = result
    }
}

// MARK: - System Prompt
private let LSM_ALPHABET_REFERENCE = """
ABECEDARIO DACTILOLÓGICO LSM — DESCRIPCIÓN TÉCNICA PARA DETECCIÓN VISUAL

REGLAS GENERALES:
- Evaluar cada letra con estos campos: CONFIGURACIÓN DE DEDOS, ESTADO DEL PULGAR, ORIENTACIÓN DE PALMA, DIRECCIÓN PRINCIPAL, CONTACTO ENTRE DEDOS, APERTURA/SEPARACIÓN y MOVIMIENTO.
- Clasificar cada dedo como: EXTENDIDO, SEMIFLEXIONADO, FLEXIONADO o GARRA.
- Usar “JUNTOS” solo si no hay separación visible entre dedos; usar “SEPARADOS” cuando exista apertura clara.
- Para letras con movimiento, NO decidir con un solo frame; exigir secuencia temporal de varios frames.
- Cuando una letra tenga forma muy parecida a otra, aplicar primero REGLAS DURAS de descarte.

A:
- CONFIGURACIÓN: puño cerrado.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: FLEXIONADOS hacia la palma.
- PULGAR: EXTENDIDO hacia el costado, pegado al lateral del puño, NO cruzado por encima.
- PALMA: al frente o ligeramente frontal.
- CONTACTO: los cuatro dedos compactos entre sí.
- REGLA DURA: si el pulgar está ENCIMA del puño, NO es A; probablemente es S.
- DISTINCIÓN: A = puño cerrado + pulgar lateral visible.

B:
- CONFIGURACIÓN: mano plana vertical.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: EXTENDIDOS, RECTOS, JUNTOS, alineados hacia arriba.
- PULGAR: FLEXIONADO contra la palma, oculto o casi oculto.
- PALMA: completamente al frente.
- CONTACTO: dedos centrales unidos sin apertura en abanico.
- REGLA DURA: si el pulgar se ve separado lateralmente, NO es B.
- DISTINCIÓN: cuatro dedos arriba y pulgar escondido.

C:
- CONFIGURACIÓN: curva abierta tipo “C”.
- TODOS LOS DEDOS: CURVADOS de forma uniforme, sin cerrar el círculo.
- PULGAR: curvado y opuesto a los demás, dejando abertura visible.
- PALMA: lateral.
- CONTACTO: NO hay unión completa entre puntas; el espacio interior de la C debe ser visible.
- REGLA DURA: si las puntas se tocan y se cierra el aro, NO es C; probablemente es O.
- DISTINCIÓN: forma de cilindro o taza, abierta.

D:
- CONFIGURACIÓN: índice vertical aislado.
- ÍNDICE: EXTENDIDO hacia arriba.
- MEDIO, ANULAR y MEÑIQUE: FLEXIONADOS.
- PULGAR: toca o se aproxima a las puntas de medio/anular/meñique formando aro inferior.
- PALMA: al frente.
- CONTACTO: base redonda abajo + índice recto arriba.
- REGLA DURA: si el índice no es el único dedo superior dominante, NO es D.
- DISTINCIÓN: “1” arriba con aro abajo.

E:
- CONFIGURACIÓN: dedos recogidos, pero NO puño compacto.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: SEMIFLEXIONADOS, con puntas hacia abajo/adelante.
- PULGAR: FLEXIONADO debajo o contra la palma.
- PALMA: al frente.
- VISUAL: los nudillos delanteros y uñas pueden verse de frente.
- REGLA DURA: si los dedos están totalmente cerrados formando puño duro, NO es E.
- DISTINCIÓN: mano cerrándose “a medias”, más abierta que A o S.

F:
- CONFIGURACIÓN: aro índice-pulgar + tres dedos arriba.
- ÍNDICE: curvado hacia el pulgar.
- PULGAR: toca el índice lateralmente o en punta, formando aro pequeño.
- MEDIO, ANULAR y MEÑIQUE: EXTENDIDOS y hacia arriba.
- PALMA: lateral o semilateral.
- REGLA DURA: si los tres dedos superiores no están claramente extendidos, NO es F.
- DISTINCIÓN: aro pequeño abajo/lado + tres dedos rectos.

G:
- CONFIGURACIÓN: pinza horizontal.
- ÍNDICE: EXTENDIDO horizontalmente hacia un lado.
- PULGAR: EXTENDIDO casi paralelo al índice.
- MEDIO, ANULAR y MEÑIQUE: FLEXIONADOS.
- PALMA: hacia adentro o semilateral.
- DIRECCIÓN PRINCIPAL: horizontal, NO vertical.
- REGLA DURA: si el índice apunta hacia arriba y el pulgar al lado en 90°, NO es G; es L.
- DISTINCIÓN: índice y pulgar como “pinza” lateral.

H:
- CONFIGURACIÓN: dos dedos horizontales juntos.
- ÍNDICE y MEDIO: EXTENDIDOS, JUNTOS, paralelos, apuntando lateralmente.
- PULGAR: extendido o elevado arriba.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- PALMA: hacia adentro.
- REGLA DURA: si índice y medio apuntan hacia ARRIBA, NO es H; probablemente es U.
- DISTINCIÓN: dos dedos juntos, pero horizontales.

I:
- CONFIGURACIÓN: puño con meñique libre.
- MEÑIQUE: EXTENDIDO hacia arriba.
- ÍNDICE, MEDIO, ANULAR: FLEXIONADOS.
- PULGAR: recogido o apoyado.
- PALMA: lateral.
- REGLA DURA: si además del meñique también está extendido el pulgar, NO es I; es Y.
- DISTINCIÓN: solo un dedo visible arriba: el meñique.

J:
- CONFIGURACIÓN BASE: igual que I.
- FORMA BASE: puño con MEÑIQUE EXTENDIDO.
- MOVIMIENTO: el meñique dibuja una curva descendente y luego hacia adentro, formando trayectoria tipo J.
- PALMA: lateral.
- REGLA DURA: sin trayectoria curva detectable, clasificar como I.
- DISTINCIÓN: J = I + movimiento trazado.

K:
- CONFIGURACIÓN: V vertical con pulgar entre ambos dedos.
- ÍNDICE y MEDIO: EXTENDIDOS y SEPARADOS.
- PULGAR: colocado ENTRE índice y medio, tocando o acercándose a la base media.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- PALMA/MUÑECA: inclinación hacia arriba.
- REGLA DURA: si el pulgar no queda entre índice y medio, NO es K.
- DISTINCIÓN: V + pulgar intermedio + orientación hacia arriba.

L:
- CONFIGURACIÓN: ángulo recto claro.
- ÍNDICE: EXTENDIDO hacia arriba.
- PULGAR: EXTENDIDO horizontalmente al costado.
- MEDIO, ANULAR y MEÑIQUE: FLEXIONADOS.
- PALMA: al frente.
- ÁNGULO: cercano a 90° entre índice y pulgar.
- REGLA DURA: si índice y pulgar están casi paralelos, NO es L; probablemente es G.
- DISTINCIÓN: silueta de “L” muy clara.

M:
- CONFIGURACIÓN: puño con pulgar cubierto por tres dedos.
- PULGAR: flexionado hacia la palma.
- ÍNDICE, MEDIO y ANULAR: doblados sobre el pulgar, cubriéndolo.
- MEÑIQUE: también flexionado.
- PALMA: al frente.
- REGLA DURA: deben verse TRES dedos por encima del pulgar.
- DISTINCIÓN: puente de 3 dedos sobre pulgar.

N:
- CONFIGURACIÓN: puño con pulgar cubierto por dos dedos.
- PULGAR: flexionado hacia la palma.
- ÍNDICE y MEDIO: sobre el pulgar.
- ANULAR y MEÑIQUE: flexionados, pero sin cubrir el pulgar de la misma forma principal.
- PALMA: al frente.
- REGLA DURA: si parecen tres dedos sobre el pulgar, reclasificar a M.
- DISTINCIÓN: puente de 2 dedos sobre pulgar.

Ñ:
- CONFIGURACIÓN BASE: igual que N.
- FORMA BASE: índice y medio sobre pulgar.
- MOVIMIENTO: oscilación corta lateral de muñeca.
- PALMA: frontal o semilateral.
- REGLA DURA: sin oscilación lateral, clasificar como N.
- DISTINCIÓN: Ñ = N + movimiento lateral.

O:
- CONFIGURACIÓN: círculo cerrado.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: curvados hacia la punta del pulgar.
- PULGAR: se une con las puntas para cerrar el contorno.
- PALMA: semilateral o frontal suave.
- CONTACTO: cierre casi completo del aro.
- REGLA DURA: si queda una abertura amplia, NO es O; probablemente es C.
- DISTINCIÓN: círculo compacto y cerrado.

P:
- CONFIGURACIÓN BASE: igual que K.
- ÍNDICE y MEDIO: EXTENDIDOS y separados.
- PULGAR: ENTRE índice y medio.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- MUÑECA: inclinada hacia abajo; dirección general descendente.
- REGLA DURA: misma mano que K, pero orientación descendente.
- DISTINCIÓN: P = K rotada hacia abajo.

Q:
- CONFIGURACIÓN: garra índice-pulgar orientada hacia abajo.
- ÍNDICE: curvado o proyectado hacia abajo.
- PULGAR: opuesto al índice, también hacia abajo.
- MEDIO, ANULAR y MEÑIQUE: flexionados.
- PALMA: hacia abajo.
- MOVIMIENTO: desplazamiento lateral corto de muñeca si se usa variante dinámica.
- REGLA DURA: si la orientación principal no es hacia abajo, NO es Q.
- DISTINCIÓN: pinza/garra baja.

R:
- CONFIGURACIÓN: índice y medio cruzados.
- ÍNDICE y MEDIO: EXTENDIDOS y ENTRELAZADOS o cruzados.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- PULGAR: recogido o semiextendido.
- PALMA: al frente.
- REGLA DURA: si los dedos están juntos pero no cruzados, NO es R; puede ser U.
- DISTINCIÓN: cruce claro de los dos dedos superiores.

S:
- CONFIGURACIÓN: puño cerrado compacto.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: FLEXIONADOS y cerrados.
- PULGAR: doblado ENCIMA del puño, cubriendo los dedos.
- PALMA: al frente.
- REGLA DURA: pulgar arriba o sobre el frente del puño.
- DISTINCIÓN: puño con pulgar encima; no lateral.

T:
- CONFIGURACIÓN: puño con pulgar asomando entre dos dedos.
- PULGAR: introducido ENTRE índice y medio.
- ÍNDICE, MEDIO, ANULAR y MEÑIQUE: flexionados en puño.
- PALMA: al frente.
- VISUAL: el pulgar debe asomar desde el centro superior/frontal del puño.
- REGLA DURA: si el pulgar queda totalmente escondido, NO es T.
- DISTINCIÓN: pulgar visible entre índice y medio.

U:
- CONFIGURACIÓN: dos dedos verticales juntos.
- ÍNDICE y MEDIO: EXTENDIDOS hacia arriba, MUY JUNTOS, paralelos.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- PULGAR: recogido.
- PALMA: al frente.
- REGLA DURA: si hay separación notable entre índice y medio, NO es U; puede ser V.
- DISTINCIÓN: dos líneas paralelas cerradas.

V:
- CONFIGURACIÓN: dos dedos verticales abiertos.
- ÍNDICE y MEDIO: EXTENDIDOS hacia arriba y SEPARADOS.
- ANULAR y MEÑIQUE: FLEXIONADOS.
- PULGAR: recogido.
- PALMA: al frente.
- REGLA DURA: apertura visible entre índice y medio.
- DISTINCIÓN: V abierta; no dedos pegados.

W:
- CONFIGURACIÓN: tres dedos superiores abiertos.
- ÍNDICE, MEDIO y ANULAR: EXTENDIDOS y SEPARADOS.
- MEÑIQUE: FLEXIONADO.
- PULGAR: FLEXIONADO.
- PALMA: al frente.
- REGLA DURA: deben verse tres puntas principales arriba.
- DISTINCIÓN: abanico de tres dedos.

X:
- CONFIGURACIÓN: índice en gancho.
- ÍNDICE: SEMIEXTENDIDO con punta fuertemente curvada, formando gancho.
- PULGAR: en garra o recogido cercano.
- MEDIO, ANULAR y MEÑIQUE: flexionados.
- PALMA: lateral.
- MOVIMIENTO: pequeño avance y retroceso si se usa variante dinámica.
- REGLA DURA: si el índice está completamente recto, NO es X.
- DISTINCIÓN: dedo índice con forma de gancho.

Y:
- CONFIGURACIÓN: meñique y pulgar abiertos.
- MEÑIQUE: EXTENDIDO.
- PULGAR: EXTENDIDO lateralmente.
- ÍNDICE, MEDIO y ANULAR: FLEXIONADOS.
- PALMA: hacia adentro o semilateral.
- REGLA DURA: dos extremos abiertos, tres centrales cerrados.
- DISTINCIÓN: “shaka” o cuernos suaves, pero sin índice extendido.

Z:
- CONFIGURACIÓN BASE: mano semicerrada con índice libre.
- ÍNDICE: EXTENDIDO.
- MEDIO, ANULAR, MEÑIQUE: FLEXIONADOS.
- PULGAR: recogido o de apoyo.
- PALMA: al frente.
- MOVIMIENTO: trazo de Z en el aire, horizontal + diagonal + horizontal.
- REGLA DURA: sin trazo reconocible, NO es Z; puede ser D o índice señalando.
- DISTINCIÓN: Z = índice extendido + trayectoria en zigzag.

LL:
- CONFIGURACIÓN BASE: igual que L.
- FORMA BASE: índice arriba + pulgar lateral en 90°.
- MOVIMIENTO: desplazamiento suave hacia afuera o lateral.
- REGLA DURA: sin movimiento, clasificar como L.
- DISTINCIÓN: LL = L + salida lateral.

RR:
- CONFIGURACIÓN BASE: igual que R.
- FORMA BASE: índice y medio cruzados.
- MOVIMIENTO: vibración o temblor corto de muñeca/mano.
- REGLA DURA: sin vibración, clasificar como R.
- DISTINCIÓN: RR = R + repetición/vibración.

CH:
- CONFIGURACIÓN BASE: igual que C.
- FORMA BASE: curva abierta tipo C.
- MOVIMIENTO: desplazamiento lateral corto.
- PALMA: lateral.
- REGLA DURA: si el círculo se cierra, NO es CH; revisar O.
- DISTINCIÓN: CH = C + movimiento lateral.
"""

// MARK: - System Prompt
private func buildSystemPrompt(handData: String) -> String {
"""
Eres un experto certificado en Lengua de Señas Mexicana (LSM).
TU ÚNICA TAREA ES IDENTIFICAR LETRAS DEL ABECEDARIO DACTILOLÓGICO LSM (A-Z y Ñ).
No identifiques palabras, frases ni señas de vocabulario, SOLO LETRAS INDIVIDUALES.

REFERENCIA OFICIAL DEL ABECEDARIO LSM:
\(LSM_ALPHABET_REFERENCE)

DATOS GEOMÉTRICOS DE LA MANO (extraídos por Apple Vision Framework):
\(handData)

INSTRUCCIONES:
1. Usa los datos geométricos como fuente principal. Son coordenadas exactas de las articulaciones.
2. Confirma visualmente con la imagen.
3. Compara el patrón de dedos extendidos/doblados con la referencia LSM.
4. Un dedo está EXTENDIDO si su punta está lejos de la muñeca. DOBLADO si está cerca.

LETRAS FÁCILES DE CONFUNDIR — presta especial atención:
- A vs S vs E: A tiene pulgar al lado, S tiene pulgar ENCIMA, E muestra uñas
- U vs V: U dedos JUNTOS, V dedos SEPARADOS
- N vs M: N usa 2 dedos sobre pulgar, M usa 3 dedos sobre pulgar
- G vs L: G apunta horizontal, L forma ángulo recto índice-pulgar
- I vs Y: I solo meñique, Y meñique + pulgar
- K vs P: K muñeca arriba, P muñeca abajo

Responde EXACTAMENTE en este formato, sin texto extra:

SEÑA: [letra A-Z o Ñ]
TIPO: [ABECEDARIO]
SIGNIFICADO: [nombre de la letra, ej: "Letra A"]
MANOS: [describe lo que ves en los datos geométricos, 1 línea]
CONFIANZA: [ALTA / MEDIA / BAJA]

Si no hay datos de mano: SEÑA: No detectada
Si no puedes identificar: SEÑA: No identificada
"""
}

// MARK: - Gemini API Structs
private struct GeminiContent: Encodable { let role: String; let parts: [GeminiPart] }
private struct GeminiPart: Encodable { var text: String?; var inlineData: GeminiInlineData? }
private struct GeminiInlineData: Encodable { let mimeType: String; let data: String }
private struct GeminiConfig: Encodable { let maxOutputTokens: Int; let temperature: Double }
private struct GeminiRequest: Encodable {
    let contents: [GeminiContent]
    let generationConfig: GeminiConfig
}
private struct GeminiResponse: Decodable {
    struct Candidate: Decodable {
        struct Content: Decodable {
            struct Part: Decodable { let text: String? }
            let parts: [Part]
        }
        let content: Content
    }
    let candidates: [Candidate]
}

// MARK: - Gemini Request
private func performGeminiRequest(_ jpegData: Data, handDescription: String) async throws -> String {
    let pool = GeminiKeyPool.shared
    let apiKey = pool.current

    let prompt = buildSystemPrompt(handData: handDescription)
    let body = GeminiRequest(
        contents: [GeminiContent(role: "user", parts: [
            GeminiPart(text: prompt),
            GeminiPart(inlineData: GeminiInlineData(mimeType: "image/jpeg", data: jpegData.base64EncodedString())),
            GeminiPart(text: "Basándote en los datos geométricos y la imagen, ¿qué letra LSM muestra esta mano?")
        ])],
        generationConfig: GeminiConfig(maxOutputTokens: 400, temperature: 0.05)
    )
    guard let url = URL(string: "\(GEMINI_URL)?key=\(apiKey)") else { throw URLError(.badURL) }
    var req = URLRequest(url: url)
    req.httpMethod = "POST"; req.timeoutInterval = 45
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try JSONEncoder().encode(body)
    let (data, response) = try await URLSession.shared.data(for: req)
    if let http = response as? HTTPURLResponse, http.statusCode != 200 {
        let msg = String(data: data, encoding: .utf8) ?? "Sin detalle"
        print("❌ Gemini \(http.statusCode): \(msg)")
        if http.statusCode == 400 || http.statusCode == 429 {
            _ = pool.rotateOnFailure(apiKey)
        }
        throw NSError(domain: "GeminiError", code: http.statusCode,
                      userInfo: [NSLocalizedDescriptionKey: "[\(http.statusCode)] \(msg)"])
    }
    let decoded = try JSONDecoder().decode(GeminiResponse.self, from: data)
    return decoded.candidates.first?.content.parts.compactMap { $0.text }.joined() ?? ""
}

private func analyzeImage(_ jpegData: Data, handDescription: String) async throws -> String {
    let maxRetries = max(1, min(GeminiKeyPool.shared.availableCount, 5))
    var lastError: Error = URLError(.unknown)
    for attempt in 1...maxRetries {
        do {
            return try await performGeminiRequest(jpegData, handDescription: handDescription)
        } catch let error as NSError {
            lastError = error
            let shouldRetry = error.code == 503 || error.code == 429 ||
                              error.code == 400 || error.domain == NSURLErrorDomain
            guard shouldRetry && attempt < maxRetries else { break }
            if error.code == 503 {
                try? await Task.sleep(nanoseconds: UInt64(attempt) * 1_000_000_000)
            }
        }
    }
    throw lastError
}

// MARK: - LSMResult
struct LSMResult: Identifiable, Equatable {
    let id = UUID()
    let sena: String
    let tipo: String
    let significado: String
    let manos: String
    let confianza: String
    let timestamp: Date
    let handCount: Int

    static func parse(_ raw: String, handCount: Int = 1) -> LSMResult {
        var sena = "No detectada"; var tipo = "ABECEDARIO"; var sig = ""; var manos = ""; var conf = "MEDIA"
        for line in raw.components(separatedBy: "\n") {
            let up = line.uppercased()
            if up.hasPrefix("SEÑA:")          { sena  = val(line) }
            else if up.hasPrefix("TIPO:")     { tipo  = val(line) }
            else if up.hasPrefix("SIGNIF")    { sig   = val(line) }
            else if up.hasPrefix("MANOS:")    { manos = val(line) }
            else if up.hasPrefix("CONFIAN")   { conf  = val(line).uppercased() }
        }
        return LSMResult(sena: sena, tipo: tipo, significado: sig,
                         manos: manos, confianza: conf, timestamp: Date(), handCount: handCount)
    }

    private static func val(_ line: String) -> String {
        line.components(separatedBy: ":").dropFirst().joined(separator: ":").trimmingCharacters(in: .whitespaces)
    }

    var isDetected: Bool { sena != "No detectada" && sena != "No identificada" && !sena.isEmpty }
    var isAlphabet: Bool { tipo.uppercased().contains("ABECEDARIO") }

    var confianzaColor: Color {
        switch confianza {
        case "ALTA":  return Color("Verde")
        case "MEDIA": return Color("Amarillo")
        default:      return Color("Rosa")
        }
    }
    var confianzaFill: CGFloat {
        switch confianza {
        case "ALTA":  return 0.85
        case "MEDIA": return 0.50
        default:      return 0.25
        }
    }
    var timeString: String {
        let f = DateFormatter(); f.dateFormat = "HH:mm:ss"; return f.string(from: timestamp)
    }
    var hourString: String {
        let f = DateFormatter(); f.dateFormat = "HH:mm"; return f.string(from: timestamp)
    }
}

// MARK: - Hand Detector
struct HandAnalysis {
    let count: Int
    let confidence: Float
    let structuredDescription: String
}

final class HandDetector {
    private let request = VNDetectHumanHandPoseRequest()
    init() { request.maximumHandCount = 2 }

    func analyze(in image: UIImage) -> HandAnalysis {
        guard let cg = image.cgImage else { return .empty }
        let handler = VNImageRequestHandler(cgImage: cg, options: [:])
        try? handler.perform([request])
        guard let obs = request.results, !obs.isEmpty else { return .empty }
        let avgConf = obs.map { $0.confidence }.reduce(0, +) / Float(obs.count)
        let desc = obs.enumerated().map { i, o in describeHand(o, index: i+1, total: obs.count) }.joined(separator: "\n\n")
        return HandAnalysis(count: obs.count, confidence: avgConf, structuredDescription: desc)
    }

    func quickClassify(from description: String) -> String? {
        let lines = description.components(separatedBy: "\n")
        var extended: [String] = []
        for line in lines {
            if line.contains("EXTENDIDO") && !line.hasPrefix("  Extendidos") {
                if let name = line.components(separatedBy: ":").first?.trimmingCharacters(in: .whitespaces) {
                    extended.append(name)
                }
            }
        }
        let extSet = Set(extended)
        switch extSet {
        case ["Meñique"]:                              return "I"
        case ["Pulgar", "Meñique"]:                   return "Y"
        case ["Índice", "Pulgar"]:                    return "L"
        case ["Índice", "Medio", "Anular", "Meñique", "Pulgar"]: return "B"
        default:                                       return nil
        }
    }

    private func describeHand(_ obs: VNHumanHandPoseObservation, index: Int, total: Int) -> String {
        var lines: [String] = []
        if total > 1 { lines.append("=== MANO \(index) ===") }
        let wrist = (try? obs.recognizedPoint(.wrist)).flatMap { $0.confidence > 0.2 ? $0 : nil }
        let fingers: [(String, [VNHumanHandPoseObservation.JointName])] = [
            ("Pulgar",  [.thumbCMC, .thumbMP,   .thumbIP,   .thumbTip]),
            ("Índice",  [.indexMCP, .indexPIP,  .indexDIP,  .indexTip]),
            ("Medio",   [.middleMCP,.middlePIP, .middleDIP, .middleTip]),
            ("Anular",  [.ringMCP,  .ringPIP,   .ringDIP,   .ringTip]),
            ("Meñique", [.littleMCP,.littlePIP, .littleDIP, .littleTip])
        ]
        var fingerStates: [String: String] = [:]
        var tipPositions: [String: CGPoint] = [:]

        for (name, joints) in fingers {
            let pts = joints.compactMap { j -> VNRecognizedPoint? in
                guard let p = try? obs.recognizedPoint(j), p.confidence > 0.25 else { return nil }
                return p
            }
            guard pts.count >= 3 else { lines.append("\(name): no detectado"); continue }
            let mcp = pts[0].location
            let tip = pts.last!.location
            tipPositions[name] = tip
            let state: String
            if let w = wrist {
                let distToTip = dist(w.location, tip)
                let distToMCP = dist(w.location, mcp)
                let threshold: CGFloat = name == "Pulgar" ? 1.3 : 1.7
                if distToTip > distToMCP * threshold {
                    state = "EXTENDIDO"
                } else {
                    let pip = pts[1].location
                    state = dist(pip, tip) < dist(mcp, pip) * 0.8 ? "DOBLADO_COMPLETAMENTE" : "DOBLADO_PARCIALMENTE"
                }
            } else {
                state = tip.y > mcp.y + 0.05 ? "EXTENDIDO" : "DOBLADO"
            }
            fingerStates[name] = state
            lines.append("\(name): \(state) — punta en (\(String(format: "%.2f", tip.x)), \(String(format: "%.2f", tip.y)))")
        }

        lines.append("")
        lines.append("ANÁLISIS DE CONFIGURACIÓN:")
        let ext  = fingerStates.filter { $0.value == "EXTENDIDO" }.map { $0.key }
        let bent = fingerStates.filter { $0.value != "EXTENDIDO" }.map { $0.key }
        lines.append("  Extendidos (\(ext.count)): \(ext.isEmpty ? "ninguno" : ext.joined(separator: ", "))")
        lines.append("  Doblados (\(bent.count)): \(bent.isEmpty ? "ninguno" : bent.joined(separator: ", "))")

        if ext.isEmpty                               { lines.append("  PATRÓN: Puño cerrado — posibles: A, E, M, N, S, T") }
        if ext == ["Meñique"]                        { lines.append("  PATRÓN: Solo meñique — letra I") }
        if Set(ext) == Set(["Pulgar","Meñique"])     { lines.append("  PATRÓN: Pulgar y meñique — letra Y") }
        if Set(ext) == Set(["Índice","Pulgar"])      { lines.append("  PATRÓN: Índice y pulgar — posible L o G") }
        if ext == ["Índice"]                         { lines.append("  PATRÓN: Solo índice — posible D, X") }
        if Set(ext) == Set(["Índice","Medio"])       { lines.append("  PATRÓN: Índice y medio — posibles: H, U, V, R, K, N") }
        if ext.count == 5                            { lines.append("  PATRÓN: Todos extendidos — posible B") }

        if let i = tipPositions["Índice"], let m = tipPositions["Medio"] {
            let s = dist(i, m)
            let d = s < 0.05 ? "MUY JUNTOS (→ U, H)" : s < 0.12 ? "SEPARADOS (→ V, K, R)" : "MUY SEPARADOS (→ V)"
            lines.append("  Separación índice-medio: \(String(format: "%.3f", s)) — \(d)")
        }
        if let i = tipPositions["Índice"], let r = tipPositions["Anular"], ext.count >= 3, dist(i, r) > 0.12 {
            lines.append("  Dedos muy separados — posible W")
        }
        if let th = tipPositions["Pulgar"] {
            for (n, t) in tipPositions where n != "Pulgar" {
                if dist(th, t) < 0.06 { lines.append("  CONTACTO: Pulgar toca \(n) — posibles: O, F, D"); break }
            }
        }
        return lines.joined(separator: "\n")
    }

    private func dist(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))
    }
}

private extension HandAnalysis {
    static let empty = HandAnalysis(count: 0, confidence: 0, structuredDescription: "Sin manos detectadas.")
}

// MARK: - Orientation Manager
final class OrientationManager: ObservableObject {
    @Published var angle: CGFloat = 90

    init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        update()
        NotificationCenter.default.addObserver(
            self, selector: #selector(update),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )
    }

    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self)
    }

    @objc func update() {
        DispatchQueue.main.async {
            let orientation = UIDevice.current.orientation
            switch orientation {
            case .portrait:           self.angle = 90
            case .portraitUpsideDown: self.angle = 270
            case .landscapeLeft:      self.angle = 180
            case .landscapeRight:     self.angle = 0
            default:
                // Si la orientación es desconocida o plana, usa la de la interfaz
                let interfaceOrientation = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first?.effectiveGeometry.interfaceOrientation ?? .portrait
                switch interfaceOrientation {
                case .portrait:           self.angle = 90
                case .portraitUpsideDown: self.angle = 270
                case .landscapeLeft:      self.angle = 180
                case .landscapeRight:     self.angle = 0
                default:                  self.angle = 90
                }
            }
        }
    }
}

// MARK: - Camera Manager
final class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let session = AVCaptureSession()
    private(set) var lastFrame: UIImage? { willSet { objectWillChange.send() } }
    private(set) var isRunning: Bool = false { willSet { objectWillChange.send() } }
    private let output = AVCaptureVideoDataOutput()
    private let queue = DispatchQueue(label: "cam.q", qos: .userInitiated)
    private let ciContext = CIContext()
    private var pos: AVCaptureDevice.Position = .front

    func start() {
        queue.async { self.configure() }
        NotificationCenter.default.addObserver(self, selector: #selector(sessionWasInterrupted),
                                               name: AVCaptureSession.wasInterruptedNotification, object: session)
        NotificationCenter.default.addObserver(self, selector: #selector(sessionInterruptionEnded),
                                               name: AVCaptureSession.interruptionEndedNotification, object: session)
    }

    func stop() {
        queue.async { self.session.stopRunning() }
        DispatchQueue.main.async { self.isRunning = false }
        NotificationCenter.default.removeObserver(self)
    }

    func flip() {
        pos = pos == .front ? .back : .front
        queue.async { self.session.stopRunning(); self.configure() }
    }

    func frame() -> UIImage? { lastFrame }

    func updateRotation(to angle: CGFloat) {
        queue.async {
            if let c = self.output.connection(with: .video),
               c.isVideoRotationAngleSupported(angle) {
                c.videoRotationAngle = angle
            }
        }
    }

    @objc private func sessionWasInterrupted(_: Notification) {
        DispatchQueue.main.async { self.isRunning = false }
    }
    @objc private func sessionInterruptionEnded(_: Notification) {
        queue.async { self.session.startRunning() }
        DispatchQueue.main.async { self.isRunning = true }
    }

    private func rotationAngle(for orientation: UIDeviceOrientation) -> CGFloat {
        switch orientation {
        case .portrait:           return 90
        case .portraitUpsideDown: return 270
        case .landscapeLeft:      return 180
        case .landscapeRight:     return 0
        default:                  return 90
        }
    }

    private func configure() {
        session.beginConfiguration()
        session.inputs.forEach  { session.removeInput($0) }
        session.outputs.forEach { session.removeOutput($0) }
        session.sessionPreset = .hd1280x720
        guard let dev = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: pos),
              let inp = try? AVCaptureDeviceInput(device: dev), session.canAddInput(inp)
        else { session.commitConfiguration(); return }
        session.addInput(inp)
        output.setSampleBufferDelegate(self, queue: queue)
        output.alwaysDiscardsLateVideoFrames = true
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        if session.canAddOutput(output) {
            session.addOutput(output)
            if let c = output.connection(with: .video) {
                let angle = rotationAngle(for: UIDevice.current.orientation)
                if c.isVideoRotationAngleSupported(angle) { c.videoRotationAngle = angle }
                if pos == .front && c.isVideoMirroringSupported { c.isVideoMirrored = true }
            }
        }
        session.commitConfiguration()
        session.startRunning()
        DispatchQueue.main.async { self.isRunning = true }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sb: CMSampleBuffer, from _: AVCaptureConnection) {
        guard let pb = CMSampleBufferGetImageBuffer(sb) else { return }
        let ci = CIImage(cvPixelBuffer: pb)
        guard let cg = ciContext.createCGImage(ci, from: ci.extent) else { return }
        DispatchQueue.main.async { self.lastFrame = UIImage(cgImage: cg, scale: 1, orientation: .up) }
    }
}

// MARK: - Camera Preview
final class PreviewUIView: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    override func layoutSubviews() { super.layoutSubviews(); previewLayer?.frame = bounds }
}

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    let rotationAngle: CGFloat

    func makeUIView(context: Context) -> PreviewUIView {
        let v = PreviewUIView(); v.backgroundColor = .black
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        if let c = l.connection, c.isVideoRotationAngleSupported(rotationAngle) {
            c.videoRotationAngle = rotationAngle
        }
        v.layer.addSublayer(l); v.previewLayer = l; return v
    }

    func updateUIView(_ v: PreviewUIView, context: Context) {
        if let c = v.previewLayer?.connection,
           c.isVideoRotationAngleSupported(rotationAngle) {
            c.videoRotationAngle = rotationAngle
        }
    }
}

// MARK: - Stores
final class HistoryStore: ObservableObject {
    @Published var items: [LSMResult] = []

    func add(_ r: LSMResult) {
        guard r.isDetected else { return }
        if let last = items.first, last.sena == r.sena, Date().timeIntervalSince(last.timestamp) < 4 { return }
        items.insert(r, at: 0)
        if items.count > 100 { items = Array(items.prefix(100)) }
    }
    func delete(_ item: LSMResult) { items.removeAll { $0.id == item.id } }
    func delete(at offsets: IndexSet) { items.remove(atOffsets: offsets) }
    func deleteAll() { items.removeAll() }
    var grouped: [(String, [LSMResult])] {
        let dict = Dictionary(grouping: items) { $0.hourString }
        return dict.sorted { $0.key > $1.key }
    }
}

final class AppSettings: ObservableObject {
    @AppStorage("showConfidence")  var showConfidence  = true
    @AppStorage("captureInterval") var captureInterval = 4.0
    @AppStorage("onboardingDone")  var onboardingDone  = false
    @AppStorage("highQuality")     var highQuality     = true
}

// MARK: - Reusable Components
struct SuccessRing: View {
    let color: Color
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 1.0
    var body: some View {
        Circle().stroke(color, lineWidth: 3).frame(width: 80, height: 80)
            .scaleEffect(scale).opacity(opacity)
            .onAppear { withAnimation(.easeOut(duration: 0.65)) { scale = 1.7; opacity = 0 } }
    }
}

struct NeonScanLine: View {
    let maxOffset: CGFloat
    @State private var offset: CGFloat = 0
    var body: some View {
        Color("Naranja").frame(height: 2)
            .shadow(color: Color("Naranja"), radius: 8)
            .shadow(color: Color("Naranja").opacity(0.4), radius: 18)
            .offset(y: offset)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) { offset = maxOffset }
            }
    }
}

struct PulseRing: View {
    let size: CGFloat
    let color: Color
    @State private var pulsing = false
    var body: some View {
        Circle()
            .stroke(color.opacity(pulsing ? 0 : 0.55), lineWidth: 2.5)
            .frame(width: size, height: size)
            .scaleEffect(pulsing ? 1.55 : 1.0)
            .onAppear { withAnimation(.easeOut(duration: 1.1).repeatForever()) { pulsing = true } }
    }
}

struct AIThinkingDots: View {
    @State private var animate = false
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3, id: \.self) { i in
                Circle().fill(Color("Naranja")).frame(width: 6, height: 6)
                    .scaleEffect(animate ? 1.0 : 0.3)
                    .opacity(animate ? 1.0 : 0.3)
                    .animation(.easeInOut(duration: 0.55).repeatForever().delay(Double(i) * 0.18), value: animate)
            }
        }
        .onAppear { animate = true }
    }
}

struct ConfidenceBar: View {
    let result: LSMResult
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Confianza").font(.system(size: 10, weight: .semibold)).foregroundColor(Color("Verde"))
                Spacer()
                Text(result.confianza).font(.system(size: 10, weight: .black)).foregroundColor(result.confianzaColor)
            }
            GeometryReader { g in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color("Amarillo").opacity(0.3)).frame(height: 5)
                    Capsule()
                        .fill(LinearGradient(colors: [result.confianzaColor, result.confianzaColor.opacity(0.55)],
                                             startPoint: .leading, endPoint: .trailing))
                        .frame(width: g.size.width * result.confianzaFill, height: 5)
                        .shadow(color: result.confianzaColor.opacity(0.7), radius: 4)
                        .animation(.spring(response: 0.7), value: result.confianza)
                }
            }
            .frame(height: 5)
        }
    }
}

struct NeonCorners: View {
    var body: some View {
        ZStack {
            ForEach([("tl", Alignment.topLeading), ("tr", Alignment.topTrailing),
                     ("bl", Alignment.bottomLeading), ("br", Alignment.bottomTrailing)], id: \.0) { key, align in
                let top = key.hasPrefix("t"), left = key.hasSuffix("l")
                ZStack {
                    Color("Naranja").frame(width: 26, height: 2.5).shadow(color: Color("Naranja"), radius: 6)
                        .offset(x: left ? 13 : -13)
                    Color("Naranja").frame(width: 2.5, height: 26).shadow(color: Color("Naranja"), radius: 6)
                        .offset(y: top ? 13 : -13)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: align)
                .padding(14)
            }
        }
    }
}

// MARK: - Splash View
struct SplashView: View {
    let onFinish: () -> Void
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    @State private var ringScale: CGFloat = 1.0
    @State private var ringOpacity: Double = 0.6
    @State private var textOpacity: Double = 0

    var body: some View {
        ZStack {
            Color("FondoOscuro").ignoresSafeArea()
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .stroke(Color("Naranja").opacity(0.08 - Double(i) * 0.02), lineWidth: 1)
                    .frame(width: CGFloat(160 + i * 75), height: CGFloat(160 + i * 75))
                    .scaleEffect(ringScale).opacity(ringOpacity)
                    .animation(.easeOut(duration: 1.6).delay(Double(i) * 0.14), value: ringScale)
            }
            VStack(spacing: 22) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color("Naranja").opacity(0.22), Color("Rosa").opacity(0.22)],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 126, height: 126)
                    Circle().stroke(Color("Naranja"), lineWidth: 2).frame(width: 126, height: 126)
                    Text("🤟").font(.system(size: 66))
                }
                .scaleEffect(scale).opacity(opacity)
                VStack(spacing: 8) {
                    Text(APP_NAME)
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(Color("Naranja"))
                    Text("Lengua de Señas Mexicana")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color("Amarillo"))
                }
                .opacity(textOpacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.6)) { scale = 1.0; opacity = 1.0 }
            withAnimation(.easeOut(duration: 1.4)) { ringScale = 1.45; ringOpacity = 0 }
            withAnimation(.easeOut(duration: 0.8).delay(0.35)) { textOpacity = 1.0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { onFinish() }
        }
    }
}

// MARK: - Onboarding
private struct OnboardingPage {
    let emoji: String; let title: String; let subtitle: String; let color: Color
}

struct OnboardingView: View {
    let onFinish: () -> Void
    @State private var page = 0
    @State private var animating = false

    private let pages: [OnboardingPage] = [
        OnboardingPage(emoji: "🤟", title: "Bienvenido a \(APP_NAME)",
            subtitle: "La primera app de traducción de Lengua de Señas Mexicana impulsada por inteligencia artificial. Muestra una seña y obtendrás la traducción en tiempo real.",
            color: Color("Naranja")),
        OnboardingPage(emoji: "✋", title: "Detección inteligente",
            subtitle: "Apple Vision Framework extrae 21 puntos articulares exactos de tu mano. Esos datos geométricos se combinan con la imagen para que Gemini AI identifique la seña con alta precisión.",
            color: Color("Rosa")),
        OnboardingPage(emoji: "📷", title: "Activa la cámara",
            subtitle: "Necesitamos acceso a tu cámara para detectar y traducir señas. Tu video nunca se guarda ni se comparte — solo se envían fotogramas estáticos y coordenadas a la IA.",
            color: Color("Azul"))
    ]

    var body: some View {
        ZStack {
            Color("FondoOscuro").ignoresSafeArea()
            Circle()
                .fill(pages[page].color.opacity(0.10))
                .frame(width: 520, height: 520).blur(radius: 80)
                .animation(.easeInOut(duration: 0.6), value: page)
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    if page < pages.count - 1 {
                        Button("Omitir") { onFinish() }
                            .font(.system(size: 15, weight: .medium)).foregroundColor(Color("Morado"))
                            .padding(.horizontal, 24).padding(.top, 58)
                    } else {
                        Color.clear.frame(height: 1).padding(.top, 58)
                    }
                }
                Spacer()
                VStack(spacing: 30) {
                    ZStack {
                        Circle().fill(pages[page].color.opacity(0.12)).frame(width: 144, height: 144)
                        Circle().stroke(pages[page].color.opacity(0.32), lineWidth: 1.5).frame(width: 144, height: 144)
                        Text(pages[page].emoji).font(.system(size: 70))
                            .scaleEffect(animating ? 1.0 : 0.6).opacity(animating ? 1 : 0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.65), value: animating)
                    }
                    VStack(spacing: 14) {
                        Text(pages[page].title)
                            .font(.system(size: 27, weight: .black, design: .rounded))
                            .foregroundColor(.white).multilineTextAlignment(.center)
                            .opacity(animating ? 1 : 0).offset(y: animating ? 0 : 16)
                            .animation(.easeOut(duration: 0.4).delay(0.08), value: animating)
                        Text(pages[page].subtitle)
                            .font(.system(size: 16)).foregroundColor(Color("Morado"))
                            .multilineTextAlignment(.center).lineSpacing(5).padding(.horizontal, 38)
                            .opacity(animating ? 1 : 0).offset(y: animating ? 0 : 16)
                            .animation(.easeOut(duration: 0.4).delay(0.16), value: animating)
                    }
                }
                Spacer()
                VStack(spacing: 24) {
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { i in
                            Capsule()
                                .fill(i == page ? pages[page].color : Color("Superficie"))
                                .frame(width: i == page ? 28 : 8, height: 8)
                                .animation(.spring(response: 0.35), value: page)
                        }
                    }
                    Button(action: nextPage) {
                        HStack(spacing: 10) {
                            Text(page == pages.count - 1 ? "Activar cámara y comenzar" : "Siguiente")
                                .font(.system(size: 17, weight: .black))
                            Image(systemName: page == pages.count - 1 ? "camera.fill" : "arrow.right")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .foregroundColor(.black).frame(maxWidth: .infinity).padding(.vertical, 20)
                        .background(pages[page].color)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .shadow(color: pages[page].color.opacity(0.45), radius: 24, y: 8)
                    }
                    .padding(.horizontal, 28)
                    .animation(.spring(response: 0.3), value: page)
                }
                .padding(.bottom, 58)
            }
        }
        .onAppear { triggerAnimation() }
    }

    private func nextPage() {
        if page < pages.count - 1 {
            animating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) { page += 1; triggerAnimation() }
        } else { onFinish() }
    }
    private func triggerAnimation() {
        animating = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) { animating = true }
    }
}

// MARK: - Content View
struct ContentView: View {
    @StateObject private var camera      = CameraManager()
    @StateObject private var history     = HistoryStore()
    @StateObject private var settings    = AppSettings()
    @StateObject private var orientation = OrientationManager()

    @State private var showSplash     = true
    @State private var showOnboarding = false
    @State private var selectedTab    = 0

    // Camera state
    @State private var cameraOn        = false
    @State private var permDenied      = false
    @State private var isLiveOn        = false
    @State private var isAnalyzing     = false
    @State private var handCount       = 0
    @State private var handConf: Float = 0
    @State private var handDescription = ""
    @State private var prevHandCount   = 0
    @State private var handBounce      = false
    @State private var current: LSMResult?   = nil
    @State private var errorMsg        = ""
    @State private var liveTask: Task<Void, Never>? = nil
    @State private var showSuccess     = false

    // Optimización
    @State private var lastAnalyzedHandDescription = ""
    @State private var stableFrameCount            = 0
    @State private var lastDetectionTime: Date     = .distantPast
    private let requiredStableFrames               = 3
    private let detectionCooldown: Double          = 2.5

    // Tamaño del cuadro guía
    private let guideWidth:  CGFloat = 196
    private let guideHeight: CGFloat = 248

    private let detector = HandDetector()

    var body: some View {
        ZStack {
            if showSplash {
                SplashView { finishSplash() }.transition(.opacity)
            } else if showOnboarding {
                OnboardingView { finishOnboarding() }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                mainApp.transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: showSplash)
        .animation(.easeInOut(duration: 0.4), value: showOnboarding)
        .preferredColorScheme(.dark)
    }

    private func finishSplash() {
        showSplash = false
        if !settings.onboardingDone { showOnboarding = true }
    }
    private func finishOnboarding() {
        settings.onboardingDone = true
        showOnboarding = false
        requestCamera()
    }

    // MARK: - Main App
    var mainApp: some View {
        TabView(selection: $selectedTab) {
            cameraTab
                .tabItem { Label("Cámara", systemImage: selectedTab == 0 ? "camera.fill" : "camera") }
                .tag(0)
            LearnView()
                .tabItem { Label("Aprender", systemImage: selectedTab == 1 ? "book.fill" : "book") }
                .tag(1)
            HistoryView(history: history)
                .tabItem { Label("Historial", systemImage: selectedTab == 2 ? "clock.fill" : "clock") }
                .tag(2)
        }
        .tint(Color("Naranja"))
        .onReceive(orientation.$angle) { angle in
            camera.updateRotation(to: angle)
        }
    }

    // MARK: - Camera Tab
    var cameraTab: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                if !cameraOn {
                    permissionPrompt.frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: 0) {
                        viewfinderArea(geo: geo)
                        if !history.items.isEmpty {
                            recentStrip.padding(.horizontal, 14).padding(.vertical, 10)
                        }
                        Spacer(minLength: 0)
                    }
                    if !errorMsg.isEmpty {
                        errorBanner
                            .padding(.horizontal, 16)
                            .padding(.bottom, history.items.isEmpty ? 90 : 10)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    private func viewfinderArea(geo: GeometryProxy) -> some View {
        let stripH: CGFloat = history.items.isEmpty ? 0 : 80
        let tabH: CGFloat   = 82
        let viewH = geo.size.height - stripH - tabH

        return ZStack {
            CameraPreview(session: camera.session, rotationAngle: orientation.angle)
            VStack {
                LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom).frame(height: 110)
                Spacer()
                LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom).frame(height: 160)
            }
            if isLiveOn { handGuide }
            if isLiveOn && handCount > 0 {
                NeonScanLine(maxOffset: viewH - 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            NeonCorners()
            if showSuccess {
                SuccessRing(color: Color("Verde")).allowsHitTesting(false)
            }
            VStack {
                cameraHUD.padding(.top, 54).padding(.horizontal, 16)
                Spacer()
            }
            VStack(spacing: 0) {
                Spacer()
                if let r = current {
                    resultOverlay(r).padding(.horizontal, 14).padding(.bottom, 12)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.spring(response: 0.45, dampingFraction: 0.75), value: current?.id)
                }
                cameraControls.padding(.bottom, 18)
            }
        }
        .frame(height: viewH)
        .clipShape(Rectangle())
        .overlay(Rectangle().stroke(isLiveOn && handCount > 0 ? Color("Naranja") : Color.clear, lineWidth: 2))
    }

    // Cuadro guía con overlay oscuro fuera del área
    private var handGuide: some View {
        ZStack {
            // Oscurece todo excepto el cuadro activo
            Color.black.opacity(0.45)
                .mask(
                    Rectangle()
                        .overlay(
                            RoundedRectangle(cornerRadius: 26)
                                .frame(width: guideWidth, height: guideHeight)
                                .blendMode(.destinationOut)
                        )
                        .compositingGroup()
                )

            // Borde del cuadro
            RoundedRectangle(cornerRadius: 26)
                .stroke(handCount > 0 ? Color("Naranja").opacity(0.9) : Color.white.opacity(0.4),
                        style: StrokeStyle(lineWidth: 2.5, dash: [10, 7]))
                .frame(width: guideWidth, height: guideHeight)
                .animation(.easeInOut(duration: 0.4), value: handCount)

            if handCount == 0 {
                VStack(spacing: 8) {
                    Image(systemName: "hand.raised")
                        .font(.system(size: 44)).foregroundColor(.white.opacity(0.5))
                    Text("Coloca tu mano aquí")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
    }

    private var cameraHUD: some View {
        HStack(spacing: 8) {
            HStack(spacing: 5) {
                Text("🤟").font(.system(size: 13))
                Text(APP_NAME).font(.system(size: 12, weight: .black)).foregroundColor(Color("Naranja"))
            }
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(.ultraThinMaterial).clipShape(Capsule())
            .overlay(Capsule().stroke(Color("Naranja").opacity(0.22), lineWidth: 1))

            Spacer()

            HStack(spacing: 6) {
                if isAnalyzing {
                    AIThinkingDots()
                    Text("Analizando").font(.system(size: 10, weight: .semibold)).foregroundColor(Color("Naranja"))
                } else {
                    Image(systemName: handCount > 0 ? "hand.raised.fill" : "hand.raised")
                        .font(.system(size: 11)).foregroundColor(handCount > 0 ? Color("Naranja") : .gray)
                        .scaleEffect(handBounce ? 1.35 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: handBounce)
                    if handCount > 0 {
                        HStack(spacing: 2) {
                            ForEach(0..<5, id: \.self) { i in
                                Capsule().fill(Float(i) < handConf * 5 ? Color("Naranja") : Color("Superficie"))
                                    .frame(width: 3, height: CGFloat(6 + i * 2))
                            }
                        }
                        Text("\(handCount)").font(.system(size: 10, weight: .bold)).foregroundColor(Color("Naranja"))
                    } else {
                        Text(isLiveOn ? "Sin mano" : "Pausado").font(.system(size: 10)).foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(.ultraThinMaterial).clipShape(Capsule())
            .overlay(Capsule().stroke(handCount > 0 ? Color("Naranja").opacity(0.3) : Color("Superficie"), lineWidth: 1))

            if isLiveOn {
                HStack(spacing: 4) {
                    Circle().fill(Color.red).frame(width: 6, height: 6).shadow(color: .red, radius: 4)
                    Text("EN VIVO").font(.system(size: 9, weight: .black)).foregroundColor(.red)
                }
                .padding(.horizontal, 8).padding(.vertical, 5)
                .background(.ultraThinMaterial).clipShape(Capsule())
            }
        }
    }

    private func resultOverlay(_ r: LSMResult) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16).fill(.ultraThinMaterial)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(r.confianzaColor.opacity(0.45), lineWidth: 1.5))
                Text(String(r.sena.prefix(1)))
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .foregroundColor(Color("Naranja"))
            }
            .frame(width: 70, height: 70)
            VStack(alignment: .leading, spacing: 5) {
                Text(r.sena).font(.system(size: 22, weight: .black, design: .rounded)).foregroundColor(.white).lineLimit(1)
                if !r.significado.isEmpty {
                    Text(r.significado).font(.system(size: 12)).foregroundColor(.white.opacity(0.62)).lineLimit(2)
                }
                if settings.showConfidence { ConfidenceBar(result: r) }
            }
            Spacer()
        }
        .padding(14)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(r.confianzaColor.opacity(0.28), lineWidth: 1))
        .shadow(color: .black.opacity(0.45), radius: 14, y: 4)
    }

    private var cameraControls: some View {
        HStack(spacing: 26) {
            Button(action: { camera.flip() }) {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                    .font(.system(size: 18, weight: .medium)).foregroundColor(.white)
                    .frame(width: 52, height: 52).background(.ultraThinMaterial).clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.14), lineWidth: 1))
            }
            Button(action: toggleLive) {
                ZStack {
                    Circle()
                        .fill(isLiveOn ? Color("Rosa") : Color("Naranja"))
                        .frame(width: 78, height: 78)
                        .shadow(color: isLiveOn ? Color("Rosa").opacity(0.6) : Color("Naranja").opacity(0.6), radius: 22, y: 4)
                    if isLiveOn { PulseRing(size: 78, color: Color("Rosa")) }
                    Image(systemName: isLiveOn ? "pause.fill" : "play.fill")
                        .font(.system(size: 28, weight: .black)).foregroundColor(.black)
                }
            }
            Button(action: { stopLive() }) {
                Image(systemName: "stop.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(isLiveOn ? Color("Rosa") : .gray)
                    .frame(width: 52, height: 52).background(.ultraThinMaterial).clipShape(Circle())
                    .overlay(Circle().stroke(isLiveOn ? Color("Rosa").opacity(0.28) : Color.clear, lineWidth: 1))
            }
            .disabled(!isLiveOn)
            .opacity(isLiveOn ? 1 : 0.45)
        }
    }

    private var recentStrip: some View {
        HStack(spacing: 0) {
            Text("RECIENTES")
                .font(.system(size: 9, weight: .black)).tracking(1).foregroundColor(.gray)
                .frame(width: 66)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(history.items.prefix(8)) { item in
                        VStack(spacing: 3) {
                            ZStack {
                                Circle().fill(Color("Naranja")).frame(width: 34, height: 34)
                                Text(item.sena.prefix(1)).font(.system(size: 15, weight: .black)).foregroundColor(.black)
                            }
                            Text(item.sena).font(.system(size: 9, weight: .bold)).foregroundColor(.white).lineLimit(1)
                        }
                        .padding(.horizontal, 8).padding(.vertical, 6)
                        .background(Color("Superficie")).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }

    private var errorBanner: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color("Amarillo"))
            Text(errorMsg).font(.system(size: 12)).foregroundColor(Color("Amarillo")).lineLimit(3)
            Spacer()
            Button(action: { withAnimation { errorMsg = "" } }) {
                Image(systemName: "xmark").font(.system(size: 11)).foregroundColor(.gray)
            }
        }
        .padding(14)
        .background(Color("Amarillo").opacity(0.12))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color("Amarillo").opacity(0.32), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.3), radius: 10, y: 2)
        .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 6) { withAnimation { errorMsg = "" } } }
    }

    private var permissionPrompt: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                Spacer(minLength: 80)
                ZStack {
                    Circle().fill(Color("Naranja")).frame(width: 144, height: 144).blur(radius: 36).opacity(0.40)
                    Circle().stroke(Color("Naranja"), lineWidth: 2).frame(width: 116, height: 116)
                    Text("📷").font(.system(size: 64))
                }
                VStack(spacing: 12) {
                    Text("Activa la cámara")
                        .font(.system(size: 30, weight: .black)).foregroundColor(Color("Naranja"))
                    Text("Manitas Mx necesita acceso a la cámara para detectar y traducir señas en tiempo real.\n\nTu video nunca se guarda ni se comparte.")
                        .font(.system(size: 15)).foregroundColor(.gray)
                        .multilineTextAlignment(.center).lineSpacing(5).padding(.horizontal, 36)
                }
                if permDenied {
                    VStack(spacing: 10) {
                        Label("Permiso denegado", systemImage: "exclamationmark.triangle.fill")
                            .font(.system(size: 14, weight: .semibold)).foregroundColor(Color("Amarillo"))
                        Text("Ve a Ajustes › Privacidad › Cámara › \(APP_NAME)")
                            .font(.system(size: 13)).foregroundColor(.gray).multilineTextAlignment(.center)
                        Button("Abrir Ajustes") {
                            if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
                        }
                        .font(.system(size: 14, weight: .semibold)).foregroundColor(Color("Azul"))
                    }
                    .padding(18)
                    .background(Color("Amarillo").opacity(0.08))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color("Amarillo").opacity(0.22), lineWidth: 1))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal, 28)
                }
                Button(action: requestCamera) {
                    HStack(spacing: 12) {
                        Image(systemName: "camera.fill").font(.system(size: 20))
                        Text("Permitir acceso a cámara").font(.system(size: 17, weight: .black))
                    }
                    .foregroundColor(.black).frame(maxWidth: .infinity).padding(.vertical, 20)
                    .background(Color("Naranja")).clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: Color("Naranja").opacity(0.5), radius: 26, y: 10)
                }
                .padding(.horizontal, 32)
                Label("Tu privacidad es nuestra prioridad", systemImage: "lock.fill")
                    .font(.system(size: 12)).foregroundColor(.gray.opacity(0.65))
                Spacer(minLength: 100)
            }
        }
    }

    // MARK: - Crop al cuadro guía
    private func cropToHandGuide(_ image: UIImage) -> UIImage {
        let imgW = image.size.width
        let imgH = image.size.height
        let x = (imgW - guideWidth)  / 2
        let y = (imgH - guideHeight) / 2
        let cropRect = CGRect(x: x, y: y, width: guideWidth, height: guideHeight)
        guard let cgImage = image.cgImage,
              let cropped = cgImage.cropping(to: cropRect) else { return image }
        return UIImage(cgImage: cropped, scale: image.scale, orientation: image.imageOrientation)
    }

    // MARK: - Camera Logic
    private func requestCamera() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted { cameraOn = true; camera.start() }
                else { permDenied = true }
            }
        }
    }

    private func toggleLive() {
        if isLiveOn { stopLive() } else { startLive() }
    }

    private func startLive() {
        isLiveOn = true
        liveTask = Task {
            while !Task.isCancelled && isLiveOn {
                await captureAndAnalyze()
                let interval: Double = handCount > 0 ? 0.5 : 0.8
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
            }
        }
    }

    private func stopLive() {
        isLiveOn = false
        liveTask?.cancel()
        liveTask = nil
        isAnalyzing = false
    }

    // MARK: - Capture & Analyze
    private func captureAndAnalyze() async {
        guard let frame = camera.frame() else { return }

        // Crop al cuadro guía — Vision trabaja solo en esa región
        let croppedFrame = cropToHandGuide(frame)
        let analysis = detector.analyze(in: croppedFrame)

        await MainActor.run {
            let newCount = analysis.count
            if newCount != prevHandCount {
                handBounce = true
                stableFrameCount = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { handBounce = false }
            }
            prevHandCount   = newCount
            handCount       = newCount
            handConf        = analysis.confidence
            handDescription = analysis.structuredDescription
        }

        guard analysis.count > 0, analysis.confidence > 0.6 else {
            await MainActor.run { stableFrameCount = 0 }
            return
        }

        // Cooldown — no analiza si ya detectó recientemente
        let timeSinceLast = Date().timeIntervalSince(lastDetectionTime)
        guard timeSinceLast >= detectionCooldown else { return }

        // Estabilidad — espera N frames con descripción diferente a la última analizada
        let descriptionChanged = handDescription != lastAnalyzedHandDescription
        await MainActor.run {
            if descriptionChanged { stableFrameCount += 1 }
            else { stableFrameCount = 0 }
        }
        guard stableFrameCount >= requiredStableFrames,
              handDescription != lastAnalyzedHandDescription else { return }

        // Cache — si ya se identificó esta configuración antes
        let cacheKey = ResultCache.shared.key(from: handDescription)
        if let cached = ResultCache.shared.get(cacheKey) {
            await MainActor.run {
                current = cached
                lastDetectionTime = Date()
                stableFrameCount = 0
            }
            return
        }

        // Clasificador local para letras simples — evita llamar a Gemini
        if let localLetter = detector.quickClassify(from: handDescription) {
            let result = LSMResult(sena: localLetter, tipo: "ABECEDARIO",
                                   significado: "Letra \(localLetter)",
                                   manos: "Clasificación local Vision",
                                   confianza: "ALTA",
                                   timestamp: Date(), handCount: analysis.count)
            await MainActor.run {
                current = result
                history.add(result)
                showSuccess = true
                lastDetectionTime = Date()
                stableFrameCount = 0
                lastAnalyzedHandDescription = handDescription
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { showSuccess = false }
            }
            ResultCache.shared.set(cacheKey, result: result)
            return
        }

        // Gemini — solo si no hubo clasificación local ni cache
        await MainActor.run {
            isAnalyzing = true
            lastAnalyzedHandDescription = handDescription
            stableFrameCount = 0
        }

        let maxRetries = max(1, min(GeminiKeyPool.shared.availableCount, 5))
        var lastError: Error = URLError(.unknown)
        var succeeded = false

        for attempt in 1...maxRetries {
            do {
                // Imagen reducida del crop
                let maxDimension: CGFloat = 300
                let scale = min(maxDimension / croppedFrame.size.width,
                                maxDimension / croppedFrame.size.height, 1.0)
                let targetSize = CGSize(width: croppedFrame.size.width * scale,
                                        height: croppedFrame.size.height * scale)
                let renderer = UIGraphicsImageRenderer(size: targetSize)
                let resized = renderer.image { _ in croppedFrame.draw(in: CGRect(origin: .zero, size: targetSize)) }
                guard let jpeg = resized.jpegData(compressionQuality: 0.50) else { return }
                guard jpeg.count < 500_000 else { return }

                let raw = try await analyzeImage(jpeg, handDescription: handDescription)
                let result = LSMResult.parse(raw, handCount: analysis.count)

                // 🖐️ LOG DETALLADO EN CONSOLA
                print("""
                \n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                🖐️  ANÁLISIS DE MANO — \(Date().formatted(date: .omitted, time: .standard))
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                📐 DATOS GEOMÉTRICOS (Vision):
                \(handDescription)
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                🤖 RESPUESTA COMPLETA DE GEMINI:
                \(raw)
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                ✅ RESULTADO PARSEADO:
                   Seña:       \(result.sena)
                   Tipo:       \(result.tipo)
                   Significado:\(result.significado)
                   Confianza:  \(result.confianza)
                   Detectado:  \(result.isDetected ? "SÍ" : "NO")
                ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n
                """)
                

                await MainActor.run {
                    isAnalyzing = false
                    if result.isDetected {
                        current = result
                        history.add(result)
                        showSuccess = true
                        lastDetectionTime = Date()
                        ResultCache.shared.set(cacheKey, result: result)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { showSuccess = false }
                    }
                }
                succeeded = true
                break

            } catch let error as NSError {
                lastError = error
                let shouldRetry = error.code == 503 || error.code == 429 ||
                                  error.code == 400 || error.domain == NSURLErrorDomain
                guard shouldRetry && attempt < maxRetries else { break }
                await MainActor.run {
                    errorMsg = "Reintentando (\(attempt)/\(maxRetries))..."
                }
                if error.code == 503 {
                    try? await Task.sleep(nanoseconds: UInt64(attempt) * 1_000_000_000)
                }
            }
        }

        if !succeeded {
            await MainActor.run {
                isAnalyzing = false
                let nsError = lastError as NSError
                errorMsg = nsError.code == 503 ? "Servicio no disponible."
                         : nsError.code == 400 ? "API key inválida."
                         : lastError.localizedDescription
            }
        }
    }
}
