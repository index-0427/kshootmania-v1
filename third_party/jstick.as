#module
#define BORDER_LOW  0x3FFF 
#define BORDER_HIGH 0xBFFF

#define global JOYERR_BASE            160
#define global MMSYSERR_NODRIVER     (MMSYSERR_BASE + 6)  /* �W���C�X�e�B�b�N�h���C�o�����݂��܂���B */
#define global MMSYSERR_INVALPARAM   (MMSYSERR_BASE + 11) /* �����ȃp�����[�^���n����܂����B */
#define global MMSYSERR_BADDEVICEID  (MMSYSERR_BASE + 2)  /* �w�肳�ꂽ�W���C�X�e�B�b�N���ʎq�͖����ł��B */
#define global JOYERR_UNPLUGGED      (JOYERR_BASE+7)      /* �w�肳�ꂽ�W���C�X�e�B�b�N�̓V�X�e���ɐڑ�����Ă��܂���B */
#define global JOYERR_NOERROR        0    ;�֐�������
 
#define global JOYERR_PARMS 165      /* �w�肳�ꂽ�W���C�X�e�B�b�N�f�o�C�X�̎��ʎq uJoyID �͖����ł��B */
 
#uselib "winmm.dll"
 
#func _joyGetPosEx "joyGetPosEx" int, var
#func joyGetNumDevs "joyGetNumDevs"
#func _joyGetDevCaps "joyGetDevCapsA" int, int, int
;joyGetDevCapsA uJoyID, pjc, cbjc
;	uJoyID	:�Ɖ��W���C�X�e�B�b�N
;	pjc		:JOYCAPS �\���̂̃A�h���X
;	cbjc	:JOYCAPS �\���̂̃T�C�Y���o�C�g�P�ʂŎw��B
 
;-----------------------------------------------
;���W���[���̏�����
;JStickIni
;	�v���O�������Ő錾����K�v�͂���܂���B
#deffunc JStickIni
    dim joycaps, 404/4    ;JOYCAPS�\����(404byte)
    joyGetNumDevs    ;�W���C�X�e�B�b�N�h���C�o�ɃT�|�[�g�����W���C�X�e�B�b�N�����擾�B
    JOYNUMDEV = stat    ;�h���C�o�����݂��Ȃ��ꍇ�́A0 ���Ԃ�܂��B
    return JOYNUMDEV
 
;�W���C�X�e�B�b�N�̈ʒu�ƃ{�^���̏�Ԃ��擾���閽��
;joyGetPosEx int p1, var data
;	p1�F�p�b�hID
;	data.0 = ��� 52  ������܂�
;	data.1 = ��� 255 ������܂�
;	data.2 = �� 1 ���̏�ԁi���ʂ̃W���C�X�e�B�b�N�� X ���j
;	data.3 = �� 2 ���̏�ԁi���ʂ̃W���C�X�e�B�b�N�� Y ���j
;	data.4 = �� 3 ���̏�ԁi�X���b�g�����j
;	data.5 = �� 4 ���̏��
;	data.6 = �� 5 ���̏��
;	data.7 = �� 6 ���̏��
;	data.8 = �{�^���̏�ԁi�ő�32�{�^���j
;	data.9 = �����ɉ�����Ă���{�^���̐�
;	data.10 = POV �X�C�b�`�̏��
;	data.11 = �\�����1
;	data.12 = �\�����2
;
;	stat = 0 �ł���Γ��͂͐���ł��B
;	�Ԃ�l					����
;	JOYERR_NOERROR			�֐��������B�W���C�X�e�B�b�N�͐ڑ����ꐳ��ɓ��삵�Ă��܂��B
;	MMSYSERR_NODRIVER		�W���C�X�e�B�b�N�h���C�o�����݂��܂���B
;	MMSYSERR_INVALPARAM		�����ȃp�����[�^���n����܂����B
;	MMSYSERR_BADDEVICEID	�w�肳�ꂽ�W���C�X�e�B�b�N���ʎq�͖����ł��B
;	JOYERR_UNPLUGGED		�w�肳�ꂽ�W���C�X�e�B�b�N�̓V�X�e���ɐڑ�����Ă��܂���B
;	JOYERR_PARMS			�w�肳�ꂽ�W���C�X�e�B�b�N�f�o�C�X�̎��ʎq uJoyID �͖����ł��B
;
;	data�͂��炩����dim data,13�Ƃ��Ĕz����m�ۂ��Ă����Ă��������B
/*
#deffunc joyGetPosEx int p1, array data
    data = 52,255    ;JOYINFOEX�\����:dwSize, dwFlags
    _joyGetPosEx p1, data
    return stat
*/
 
 
;-----------------------------------------------
;�g�p�\�ȃW���C�X�e�B�b�NID�����o����֐�
;	JStickSearchID startnum, joyidlist, number
;		startnum	�F���o���J�n����ID�i0�`�j
;		joyidlist	�F���o����ID�̈ꗗ���i�[����z��ϐ��B
;					�@�g�p�\�ȃW���C�X�e�B�b�N��ID�i0�`�j�����ׂČ��o���܂��B
;		number		�F���o������B�ȗ�(=0)�̂Ƃ��͑S�āB
;		�Ԃ�l�F���o����ID�̌�
#deffunc JStickSearchID int _startnum, array joyidlist, int _number
    startnum = limit(_startnum, 0, JOYNUMDEV)
    if _number<=0 : number = JOYNUMDEV : else : number = _number
    joyidmax = 0
    repeat JOYNUMDEV - startnum, startnum
        joyGetPosEx data,cnt
        if stat = 0 {
            joyidlist(joyidmax) = cnt
            joyidmax++
            if joyidmax>=number : break
        }
    loop
    return joyidmax
 
 
;-----------------------------------------------
;�W���C�X�e�B�b�N�̖��̂��擾���܂��B
;	name = JStickGetDevCapsPname( _uJoyID )
;		_uJoyID	�F(0�`)�W���C�p�b�h��id
;		�Ԃ�l	�F�擾�����W���C�p�b�h��
#defcfunc JStickGetDevCapsPname int _uJoyID
    if ( _uJoyID < 0 )|( _uJoyID >= JOYNUMDEV ) : return -1    ;�w�肳�ꂽid�͎g�p�ł��܂���B
    _joyGetDevCaps _uJoyID, varptr(joycaps), length(joycaps)*4
    if stat : return ""        ;����ɏ�񂪎擾�ł��Ȃ������B
    name = ""
    getstr name, joycaps, 4
    return name
 
 
;-----------------------------------------------
;�W���C�X�e�B�b�N�̐��\���擾���܂��B
;	JStickGetDevCaps _uJoyID, jinfo
;		_uJoyID	�F(0�`)�W���C�p�b�h��id
;		jinfo	�F�擾�����W���C�X�e�B�b�N�̐��\�l�B�����^�̔z��ϐ��B�v�f�̍ő��19�B
;				�K���@dim jinfo, 19�@�Ƃ��Ĕz����m�ۂ��Ă����Ă��������B
;			jinfo(0)  = wXmin;		/* X-���W */
;			jinfo(1)  = wXmax;		/* X-���W */
;			jinfo(2)  = wYmin;		/* Y-���W */
;			jinfo(3)  = wYmax;		/* Y-���W */
;			jinfo(4)  = wZmin;		/* Z-���W */
;			jinfo(5)  = wZmax;		/* Z-���W */
;			jinfo(6)  = wNumButtons;/* �{�^���̐� */
;			jinfo(7)  = wPeriodMin;	/* �|�[�����O�Ԋu�̍ŏ��l */
;			jinfo(8)  = wPeriodMax;	/* �|�[�����O�Ԋu�̍ő�l */
;			jinfo(9)  = wRmin;		/* r���W�̍ŏ��l */
;			jinfo(10) = wRmax;		/* r���W�̍ő�l */
;			jinfo(11) = wUmin;		/* u���W�̍ŏ��l */
;			jinfo(12) = wUmax;		/* u���W�̍ő�l */
;			jinfo(13) = wVmin;		/* v���W�̍ŏ��l */
;			jinfo(14) = wVmax;		/* v���W�̍ő�l */
;			jinfo(15) = wCaps;		/* �\�̓t���O */
;			jinfo(16) = wMaxAxes;	/* ���W���̍ő吔 */
;			jinfo(17) = wNumAxes;	/* ���W���̐� */
;			jinfo(18) = wMaxButtons;/* �{�^���̍ő吔 */
#deffunc JStickGetDevCaps int _uJoyID, array jinfo
    if ( _uJoyID < 0 )|( _uJoyID >= JOYNUMDEV ) : return -1    ;�w�肳�ꂽid�͎g�p�ł��܂���B
    uJoyID = _uJoyID        ;0�`
    _joyGetDevCaps uJoyID, varptr(joycaps), length(joycaps)*4
    if stat : return stat        ;����ɏ�񂪎擾�ł��Ȃ������B
 
    repeat 19
        jinfo(cnt) = lpeek(joycaps, cnt*4+36)
    loop
    return
 
 
 
#global
JStickIni
;OS�̃W���C�p�b�h�ő�F����
maxjoystick = stat    ;���̕ϐ��ɂ͒l�������Ȃ��悤�ɂ��Ă��������B
 
;���W���[�������܂�
