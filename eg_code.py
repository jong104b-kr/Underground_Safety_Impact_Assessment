import numpy as np

def dmatPlane(ntype, E, nu):
    """
    평면응력(plane stress) 또는 평면변형률(plane strain) 조건의
    강성(강성) 행렬 D를 계산하는 함수.

    파라미터
    ----------
    ntype : int
        조건 구분 (1 = 평면응력, 2 = 평면변형률)
    E : float
        탄성계수 (Young's modulus)
    nu : float
        포아송 비 (Poisson's ratio)

    반환
    ----
    dmat : numpy.ndarray (3x3)
        강성 행렬. sigma = dmat @ epsilon 관계 만족
    """
    if ntype == 1:
        # ---- 평면응력(plane stress) ----
        # D = E/(1-ν²) * [1    ν    0
        #                 ν    1    0
        #                 0    0  (1-ν)/2]
        const = E / (1.0 - nu * nu)
        dmat = np.array([
            [const,   const * nu, 0.0],
            [const * nu, const,   0.0],
            [0.0,     0.0,         const * (1.0 - nu) / 2.0]
        ])

    else:
        # ---- 평면변형률(plane strain) ----
        # D = E(1-ν)/((1+ν)(1-2ν)) * [1         ν/(1-ν)  0
        #                             ν/(1-ν)   1        0
        #                             0         0      (1-2ν)/(2(1-ν))]
        const = E * (1.0 - nu) / ((1.0 + nu) * (1.0 - 2.0 * nu))
        dmat = np.array([
            [const,           const * nu / (1.0 - nu), 0.0],
            [const * nu / (1.0 - nu), const,           0.0],
            [0.0,             0.0,                      const * (1.0 - 2.0 * nu) / (2.0 * (1.0 - nu))]
        ])

    return dmat
