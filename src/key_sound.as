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
// �m�[�gSE�̖��O���特���t�@�C���̃p�X���擾
// (�g���q���Ȃ��ꍇ�ɂ�"se\note"�f�B���N�g�����̃t�@�C�����g�p)
//
//   p1: �m�[�gSE�̖��O(��:"clap")
//
#defcfunc getKeySoundFilePathByName str p1, local name
	if(getpath(p1, 2) = ""){
		return dir_default + "\\se\\note\\" + p1 + ".wav"
	} else {
		return p1
	}

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