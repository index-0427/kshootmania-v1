#module key_sound

//
// key_sound���W���[����������
//
//   p1: ���s�t�@�C��������f�B���N�g���̃p�X(dir_default)
//
#deffunc initKeySoundModule str p1
	dir_default = p1
	return

//
// �w��o�[�W�����ɂ�����m�[�gSE�̍ő哯�����������擾
//
//   p1: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#defcfunc getKeySoundMaxForVersion int p1
	if (p1 >= 171) {
		return 1
	} else {
		return 0
	}

#global